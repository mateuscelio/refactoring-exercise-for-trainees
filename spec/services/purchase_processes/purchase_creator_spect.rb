require 'rails_helper'

module PurchaseProcesses
  RSpec.describe PurchaseCreator do
    let(:address_params) { build :address_params }
    let(:cart) { create :cart }
    it 'creates for paypal gateway' do
      expect { PurchaseCreator.call('paypal', cart.id, address_params, {}) }.to change(Order, :count).by(1)
    end
    it 'creates for stripe gateway' do
      expect { PurchaseCreator.call('paypal', cart.id, address_params, {}) }.to change(Order, :count).by(1)
    end
    it 'results in error for invalid gateway' do
      expect(PurchaseCreator.call('invalid_gateway', '', '',
                                  '').errors).to include({ message: 'Gateway not supported!' })
    end
  end
end
