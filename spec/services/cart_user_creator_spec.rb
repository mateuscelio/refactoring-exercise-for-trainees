require 'rails_helper'
RSpec.describe CartUserCreator do
  context 'Cart with valid user' do
    let(:user) { User.create(email: 'user@spec.io', first_name: 'John', last_name: 'Doe') }
    let(:cart) { user.carts.create }

    it 'returns cart user' do
      expect(CartUserCreator.call(cart, {})).to eq user
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
        expect(CartUserCreator.call(cart, valid_params).guest).to eq(true)
      end
    end

    context 'with invalid user params' do
      let(:invalid_params) { { first_name: 'John', last_name: 'Doe' } }
      it 'returns invalid user' do
        expect(CartUserCreator.call(cart, invalid_params).valid?).to eq(false)
      end
    end
  end
end
