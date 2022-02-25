module PurchaseProcesses
  class BasePurchaseProcess
    attr_reader :cart_id, :address, :user_params

    def initialize(cart_id, address, user_params)
      @cart_id = cart_id
      @address = address
      @user_params = user_params
    end

    def create_purchase_order
      cart = Cart.find_by(id: cart_id)
      return ServiceResult.error('Cart not found!') unless cart

      user_res = CartUserCreator.call(cart, user_params)

      return user_res unless user_res.success?

      OrderCreators::OrderCreator.call(user_res.value, cart, address)
    end
  end
end
