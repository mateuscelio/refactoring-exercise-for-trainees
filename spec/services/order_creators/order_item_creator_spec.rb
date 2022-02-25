module OrderCreators
  RSpec.describe OrderItemCreator do
    let(:cart) { build(:cart) }
    let(:sale) { build(:sale, name: 'My Sale V', unit_price_cents: 1_900) }
    let(:order) { build :order }

    before do
      create(:cart_item, cart: cart, sale: sale, quantity: 3)
    end

    it 'adds items to order' do
      expect(OrderItemCreator.call(order, cart, 100).items.size).to eq(3)
    end

    it 'sums items and shipping cost' do
      expect(OrderItemCreator.call(order, cart, 100).total_cents).to eq(6000)
    end
  end
end
