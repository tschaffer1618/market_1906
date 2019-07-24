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
      vendor.inventory.keys.each do |item|
        items << item
      end
    end
    items.sort.uniq
  end

  def total_inventory
    hash = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, amount|
        hash[item] += amount
      end
    end
    hash
  end



end
