module PurchaseProcesses
  class PurchaseCreator
    PURCHASE_PROCESSES = {
      'paypal': PaypalPurchaseProcess,
      'stripe': StripePurchaseProcess
    }
    def self.call(gateway, cart_id, address, user)
      process = PURCHASE_PROCESSES[gateway.to_sym]
      return ServiceResult.error('Gateway not supported!') unless process

      process.new(cart_id, address, user).create_purchase_order
    end
  end
end
