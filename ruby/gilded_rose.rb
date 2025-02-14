require 'byebug'
class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      case item.name
      when "Aged Brie"
        increase_quality(item)
      when "Backstage passes to a TAFKAL80ETC concert"
        backstage_quanlity(item)
      when "Sulfuras, Hand of Ragnaros"  
        #"Sulfuras" is a legendary item and does not change
      else
        degrade_quality(item)
      end 
      update_sell_in(item)
      check_the_contraints(item) if item.sell_in < 0
    end
  end

  def backstage_quanlity(item)
    increase_quality(item)
    if item.sell_in < 11
      increase_quality(item)
    end
    if item.sell_in < 6
      increase_quality(item)
    end
  end

  def increase_quality(item ,factor = 1)
    item.quality += factor if item.quality < 50
  end

  def degrade_quality(item, factor = 1)
    item.quality -= factor if item.quality > 0
    item.quality = 0 if item.quality < 0  # Ensure it never goes negative
  end


  def update_sell_in(item)
    item.sell_in -= 1 unless item.name == 'Sulfuras, Hand of Ragnaros'
  end

  def check_the_contraints(item)
    if item.name != "Aged Brie"
      if item.name != "Backstage passes to a TAFKAL80ETC concert"
        if item.quality > 0
          if item.name != "Sulfuras, Hand of Ragnaros"
            item.quality = item.quality - 1
          end
        end
      else
        item.quality = item.quality - item.quality
      end
    else
      if item.quality < 50
        item.quality = item.quality + 1
      end
    end
  end
end

class Item
  attr_accessor :name, :sell_in, :quality

  def initialize(name, sell_in, quality)
    @name = name
    @sell_in = sell_in
    @quality = quality
  end

  def to_s()
    "#{@name}, #{@sell_in}, #{@quality}"
  end
end
