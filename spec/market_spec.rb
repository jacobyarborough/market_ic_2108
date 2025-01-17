require 'rspec'
require './lib/item'
require './lib/vendor'
require './lib/market'
describe Market do
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market")
  end

  describe '#initialize' do
    it 'creates an instance of Market' do
      expect(@market).to be_an_instance_of(Market)
    end

    it 'has readable attributes' do
      expect(@market.name).to eq('South Pearl Street Farmers Market')
      expect(@market.vendors).to eq([])
    end
  end
  describe '#add_vendor' do
    it 'adds a vendor to the vendors array' do
      vendor1 = Vendor.new("Rocky Mountain Fresh")
      item1 = Item.new({name: 'Peach', price: "$0.75"})
      item2 = Item.new({name: 'Tomato', price: "$0.50"})
      item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2 = Vendor.new("Ba-Nom-a-Nom")
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3 = Vendor.new("Palisade Peach Shack")
      vendor3.stock(item1, 65)

      @market.add_vendor(vendor1)
      @market.add_vendor(vendor2)
      @market.add_vendor(vendor3)

      expect(@market.vendors).to include(vendor1, vendor2, vendor3)
    end
  end

  describe '#vendor_names' do
    it 'returns an array of names of vendor objects in the vendor array' do
      vendor1 = Vendor.new("Rocky Mountain Fresh")
      item1 = Item.new({name: 'Peach', price: "$0.75"})
      item2 = Item.new({name: 'Tomato', price: "$0.50"})
      item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2 = Vendor.new("Ba-Nom-a-Nom")
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3 = Vendor.new("Palisade Peach Shack")
      vendor3.stock(item1, 65)

      @market.add_vendor(vendor1)
      @market.add_vendor(vendor2)
      @market.add_vendor(vendor3)

      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe '#total_inventory' do
    it 'reports the quantites of all items sold at the market' do
      vendor1 = Vendor.new("Rocky Mountain Fresh")
      item1 = Item.new({name: 'Peach', price: "$0.75"})
      item2 = Item.new({name: 'Tomato', price: "$0.50"})
      item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
      item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
      vendor1.stock(item1, 35)
      vendor1.stock(item2, 7)
      vendor2 = Vendor.new("Ba-Nom-a-Nom")
      vendor2.stock(item4, 50)
      vendor2.stock(item3, 25)
      vendor3 = Vendor.new("Palisade Peach Shack")
      vendor3.stock(item1, 65)
      vendor3.stock(item3, 10)

      @market.add_vendor(vendor1)
      @market.add_vendor(vendor2)
      @market.add_vendor(vendor3)

      expected = {
          item1 => {
          quantity: 100,
          vendors: [vendor1, vendor3]
        },
          item2 => {
          quantity: 7,
          vendors: [vendor1]
        },
          item4 => {
          quantity: 50,
          vendors: [vendor2]
        },
          item3 => {
          quantity: 35,
          vendors: [vendor2, vendor3]
        },
      }

      expect(@market.total_inventory).to eq(expected)
    end
  end
end

it '#date' do
  allow(Date).to receive(:today).and_return(Date.new(2020, 02, 24))
  expect(@market.date).to eq("24/02/2020")
end
