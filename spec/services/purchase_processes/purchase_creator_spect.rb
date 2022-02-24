require 'rails_helper'

module PurchaseProcesses
  RSpec.describe PurchaseCreator do
    let(:address) do
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
    let(:user) { User.create(email: 'user@spec.io', first_name: 'John', last_name: 'Doe') }
    let(:cart) { user.carts.create }
    it 'creates for paypal gateway' do
      expect { PurchaseCreator.call('paypal', cart.id, address, {}) }.to change(Order, :count).by(1)
    end
    it 'creates for stripe gateway' do
      expect { PurchaseCreator.call('paypal', cart.id, address, {}) }.to change(Order, :count).by(1)
    end
    it 'results in error for invalid gateway' do
      expect(PurchaseCreator.call('invalid_gateway', '', '',
                                  '').errors).to include({ message: 'Gateway not supported!' })
    end
  end
end
