# Market holds an array of vendors that contain items

class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors.push(vendor)
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    vendors.select do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def total_inventory
    return_hash = {}
    vendors.each do |vendor|
      vendor.inventory.each do |item|
        if return_hash[item[0]].nil?
          return_hash[item[0]] = {quantity: item[1], vendors: [vendor] }
        else
          return_hash[item[0]][:quantity] += item[1]
          return_hash[item[0]][:vendors] += [vendor]
        end
      end
    end
    return_hash
  end

  def overstocked_items
    overstock = []
    total_inventory.each do |item, values|
      if values[:quantity] > 50 && values[:vendors].size > 1
        overstock << item
      end
    end
    overstock
  end

  def sorted_item_list
    items_sorted = []
    vendors.each do |vendor|
      vendor.inventory.each do |item, _|
        items_sorted << item.name
      end
    end
    items_sorted.sort.uniq
  end

  def date
    Date.today.strftime("%d/%m?%Y")
  end

  def sell(item_obj, requested)
    if total_inventory[item_obj] == 0 || total_inventory[item_obj][:quantity]
      false
    else
      until requested == 0
        vendors_that_sell(item_obj).each do |vendor|
          if vendor.inventory[item_obj] >= requested
            vendor.inventory[item_obj] -= requested
            requested = 0
          else
            requested -= vendor.inventory[item_obj]
            vendor.inventory[item_obj] = 0
          end
        end
      end
    end
  end
end
