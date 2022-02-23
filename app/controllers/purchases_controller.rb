class PurchasesController < ApplicationController
  def create
    payment_gateway = PaymentGateways::GatewaySelector.call(purchase_params[:gateway])

    unless payment_gateway
      return render json: { errors: [{ message: 'Gateway not supported!' }] },
                    status: :unprocessable_entity
    end

    cart_id = purchase_params[:cart_id]

    cart = Cart.find_by(id: cart_id)

    return render json: { errors: [{ message: 'Cart not found!' }] }, status: :unprocessable_entity unless cart

    user = CartUserCreator.call(cart, purchase_params[:user])

    unless user.valid?
      return render json: { errors: user.errors.map(&:full_message).map do |message|
                                      { message: message }
                                    end }, status: :unprocessable_entity
    end

    order = Order.new(
      user: user,
      first_name: user.first_name,
      last_name: user.last_name,
      address_1: address_params[:address_1],
      address_2: address_params[:address_2],
      city: address_params[:city],
      state: address_params[:state],
      country: address_params[:country],
      zip: address_params[:zip]
    )

    cart.items.each do |item|
      item.quantity.times do
        order.items << OrderLineItem.new(
          order: order,
          sale: item.sale,
          unit_price_cents: item.sale.unit_price_cents,
          shipping_costs_cents: shipping_costs,
          paid_price_cents: item.sale.unit_price_cents + shipping_costs
        )
      end
    end

    order.save

    if order.valid?
      render json: { status: :success, order: { id: order.id } }, status: :ok
    else
      render json: { errors: order.errors.map(&:full_message).map do |message|
                               { message: message }
                             end }, status: :unprocessable_entity
    end
  end

  private

  def purchase_params
    params.permit(
      :gateway,
      :cart_id,
      user: %i[email first_name last_name],
      address: %i[address_1 address_2 city state country zip]
    )
  end

  def address_params
    purchase_params[:address] || {}
  end

  def shipping_costs
    100
  end
end
