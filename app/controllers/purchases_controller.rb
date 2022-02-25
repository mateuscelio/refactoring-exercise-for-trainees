class PurchasesController < ApplicationController
  def create
    res = PurchaseProcesses::PurchaseCreator.call(purchase_params[:gateway], purchase_params[:cart_id],
                                                  address_params, purchase_params[:user])
    unless res.success?
      return render json: { errors: res.errors },
                    status: :unprocessable_entity
    end

    render json: { status: :success, order: { id: res.value.id } }, status: :ok
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
