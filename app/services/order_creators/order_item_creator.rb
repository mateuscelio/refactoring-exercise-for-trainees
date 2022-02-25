module OrderCreators
  class OrderItemCreator
    def self.call(order, cart, shipping_costs)
      cart.items.each do |item|
        item.quantity.times do
          order.items << OrderLineItem.new(
            order: order,
            sale: item.sale,
            unit_price_cents: item.sale.unit_price_cents,
            shipping_costs_cents: shipping_costs,
            paid_price_cents: item.sale.unit_price_cents + shipping_costs
          )
        end
      end
      order
    end
  end
end
