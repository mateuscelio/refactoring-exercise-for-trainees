require 'rails_helper'

module PaymentGateways
  RSpec.describe PaypalGateway do
    let(:paypal_gateway) {PaypalGateway.new}
    it 'return payment url' do
      expect(paypal_gateway.generate_payment_url).to  eq 'paypal.com'
    end
  end
end
