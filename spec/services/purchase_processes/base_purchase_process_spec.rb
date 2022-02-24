require 'rails_helper'

module PurchaseProcesses
  RSpec.describe BasePurchaseProcess do
    let(:address_params) { build :address_params }
    let(:user) { User.create(email: 'user@spec.io', first_name: 'John', last_name: 'Doe') }

    context 'with valid params' do
      let(:cart) { user.carts.create }
      it 'creates purchase order' do
        purchase_process = described_class.new(cart.id, address_params, {})
        expect { purchase_process.create_purchase_order }.to change(Order, :count).by(1)
      end
    end
    context 'with invalid cart id' do
      it 'results in error' do
        purchase_process = described_class.new(1, address_params, {})
        expect(purchase_process.create_purchase_order.errors).to include({ message: 'Cart not found!' })
      end
    end
  end
end
