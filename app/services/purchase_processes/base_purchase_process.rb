module PurchaseProcesses
  class BasePurchaseProcess
    def create_purchase_order
      raise NotImplementedError
    end
  end
end
