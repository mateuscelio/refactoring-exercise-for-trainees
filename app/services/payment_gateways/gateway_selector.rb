module PaymentGateways
  class GatewaySelector
    def self.call(type)
      case type
      when 'stripe'
        StripeGateway.new
      when 'paypal'
        PaypalGateway.new
      end
    end
  end
end
