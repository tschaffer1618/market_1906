class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map { |vendor| vendor.name }
  end

  def vendors_that_sell(item)
    @vendors.find_all { |vendor| vendor.inventory.keys.include?(item) }
  end

  def sorted_item_list
    items = []
    @vendors.each do |vendor|
      vendor.inventory.keys.each { |item| items << item }
    end
    items.sort.uniq
  end

  def total_inventory
    inventory = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each { |item, amount| inventory[item] += amount }
    end
    inventory
  end

  def sell(item, amount)
    if total_inventory[item] < amount
      false
    else
      amount_left = amount
      @vendors.each do |vendor|
        if amount_left > vendor.inventory[item]
          amount_left -= vendor.inventory[item]
          vendor.inventory[item] = 0
        else
          vendor.inventory[item] -= amount_left
        end
      end
      true
    end
  end
end
