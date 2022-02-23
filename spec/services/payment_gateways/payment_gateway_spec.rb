require 'rails_helper'

module PaymentGateways
  RSpec.describe PaymentGateway do
    it 'does not implement generate_payment_url' do
      payment_gateway = PaymentGateway.new
      expect { payment_gateway.generate_payment_url }.to raise_error NotImplementedError
    end
  end
end
