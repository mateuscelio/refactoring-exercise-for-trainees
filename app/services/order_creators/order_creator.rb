module OrderCreators
  class OrderCreator
    def self.call(user, cart, address_params)
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
      order = OrderItemCreator.call(order, cart, shipping_costs)
      order.save

      return ServiceResult.success(order) if order.valid?

      ServiceResult.errors(order.errors.full_messages)
    end

    def self.shipping_costs
      100
    end
  end
end
