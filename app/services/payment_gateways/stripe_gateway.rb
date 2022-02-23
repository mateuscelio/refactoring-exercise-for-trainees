module PaymentGateways
  class StripeGateway < PaymentGateway
    def generate_payment_url
      'stripe.com'
    end
  end
end
