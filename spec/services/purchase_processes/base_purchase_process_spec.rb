require 'rails_helper'

module PurchaseProcesses
  RSpec.describe BasePurchaseProcess do
    it 'does not implement create_purchase_order' do
      purchase_process = described_class.new
      expect { purchase_process.create_purchase_order }.to raise_error NotImplementedError
    end
  end
end
