require 'rails_helper'

module OrderCreators
  RSpec.describe OrderCreator do
    let(:address_params) { build :address_params }
    let(:cart) { Cart.create }

    context 'with valid user' do
      let(:user) { create :user }

      it 'creates valid order' do
        expect { OrderCreator.call(user, cart, address_params) }.to change(Order, :count).by(1)
      end
    end
    context 'with invalid user' do
      let(:user) { User.create }
      it 'does not create valid order' do
        expect(OrderCreator.call(user, cart, address_params).errors).to include({ message: 'User is invalid' })
      end
    end
  end
end
