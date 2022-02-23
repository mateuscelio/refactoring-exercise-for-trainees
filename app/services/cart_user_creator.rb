class CartUserCreator
  def self.call(cart, user_params)
    if cart.user.nil?
      new_user_params = (user_params || {}).merge(guest: true)
      User.create(new_user_params)
    else
      cart.user
    end
  end
end
