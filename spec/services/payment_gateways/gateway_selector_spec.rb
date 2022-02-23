require 'rails_helper'

module PaymentGateways
  RSpec.describe GatewaySelector do
    it 'returns a paypal gateway instance' do
      expect(GatewaySelector.call('paypal')).to be_a PaypalGateway
    end
    it 'returns a stripe gateway instance' do
      expect(GatewaySelector.call('stripe')).to be_a StripeGateway
    end
    it 'returns nill for not found gateway' do
      expect(GatewaySelector.call('invalidgateway')).to be_a NilClass
    end
  end
end
