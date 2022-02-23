module PaymentGateways
  class PaypalGateway < PaymentGateway
    def generate_payment_url
      'paypal.com'
    end
  end
end
