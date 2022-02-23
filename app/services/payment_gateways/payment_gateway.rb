module PaymentGateways
  class PaymentGateway
    def generate_payment_url
      raise NotImplementedError
    end
  end
end
