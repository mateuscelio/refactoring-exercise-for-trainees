require 'rails_helper'
RSpec.describe CartUserCreator do
  context 'Cart with valid user' do
    let(:user) { User.create(email: 'user@spec.io', first_name: 'John', last_name: 'Doe') }
    let(:cart) { user.carts.create }

    it 'returns cart user' do
      expect(CartUserCreator.call(cart, {}).value).to eq user
    end
  end

  context 'Cart without user' do
    let(:cart) { Cart.new }

    context 'with valid user params' do
      let(:valid_params) { { email: 'user@spec.io', first_name: 'John', last_name: 'Doe' } }
      it 'creates new user' do
        expect { CartUserCreator.call(cart, valid_params) }.to change(User, :count).by(1)
      end
      it 'creates a user as guest' do
        expect(CartUserCreator.call(cart, valid_params).value.guest).to eq(true)
      end
    end

    context 'with invalid user params' do
      let(:invalid_params) { { first_name: 'John', last_name: 'Doe' } }
      it 'results in errors' do
        expect(CartUserCreator.call(cart, invalid_params).errors).to include({ message: "Email can't be blank" })
      end
    end
  end
end
