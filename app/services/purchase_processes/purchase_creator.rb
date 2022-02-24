module PurchaseProcesses
  class PurchaseCreator
    PURCHASE_PROCESSES = {
      'paypal': ->(cart_id, address, user) { PaypalPurchaseProcess.new(cart_id, address, user) },
      'stripe': ->(cart_id, address, user) { StripePurchaseProcess.new(cart_id, address, user) }
    }
    def self.call(gateway, cart_id, address, user)
      process = PURCHASE_PROCESSES[gateway.to_sym]
      return ServiceResult.error('Gateway not supported!') unless process

      process.call(cart_id, address, user).create_purchase_order
    end
  end
end
