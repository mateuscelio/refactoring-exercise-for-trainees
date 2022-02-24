require 'rails_helper'
RSpec.describe OrderCreator do
  let(:address_params) do
    {
      user: user,
      first_name: user.first_name,
      last_name: user.last_name,
      address_1: 'address_1',
      address_2: 'address_2',
      city: 'city',
      state: 'state',
      country: 'country',
      zip: 'zip'
    }
  end
  let(:cart) { Cart.create }

  context 'with valid user' do
    let(:user) { User.create(email: 'user@spec.io', first_name: 'John', last_name: 'Doe') }

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
