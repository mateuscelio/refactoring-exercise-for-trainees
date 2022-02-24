class CartUserCreator
  def self.call(cart, user_params)
    user = if cart.user.nil?
            new_user_params = (user_params || {}).merge(guest: true)
            User.create(new_user_params)
           else
            cart.user
           end

    return ServiceResult.success(user) if user.valid?

    ServiceResult.errors(user.errors.full_messages)
  end
end
