require 'rails_helper'

module PaymentGateways
  RSpec.describe PaypalGateway do
    let(:stripe_gateway) { StripeGateway.new }
    it 'return payment url' do
      expect(stripe_gateway.generate_payment_url).to eq 'stripe.com'
    end
  end
end
