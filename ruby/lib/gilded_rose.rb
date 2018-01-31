class GildedRose

  AGED_BRIE = "Aged Brie"
  BACKSTAGE_PASS = "Backstage passes to a TAFKAL80ETC concert"
  SULFURAS = "Sulfuras, Hand of Ragnaros"

  def initialize(items)
    @items = items
  end

  def update_quality()

    @items.each do |item|
      if item.name != AGED_BRIE and item.name != BACKSTAGE_PASS
        reduce_quality(item)
      else
        if item.quality < 50
          item.quality += 1
          if item.name == BACKSTAGE_PASS
            if item.sell_in < 11
              increase_quality(item)
            end
            if item.sell_in < 6
              increase_quality(item)
            end
          end
        end
      end

      update_quantity_if_not_sulfuras(item)

      if item.sell_in < 0
        if item.name == AGED_BRIE
          increase_quality(item)
        elsif item.name == BACKSTAGE_PASS
          drop_backstage_pass_quality_after_concert(item)
        else
          reduce_quality(item)
        end
      end
    end

  end

end

def reduce_quality(item)
  if item.quality > 0
    update_quality_if_not_sulfuras(item)
  end
end

def update_quality_if_not_sulfuras(item)
  if item.name != "Sulfuras, Hand of Ragnaros"
    item.quality -= 1
  end
end

def update_quantity_if_not_sulfuras(item)
  if item.name != "Sulfuras, Hand of Ragnaros"
    item.sell_in -= 1
  end
end

def drop_backstage_pass_quality_after_concert(item)
  item.quality -= item.quality
end


def increase_quality(item)
  if item.quality < 50
    item.quality += 1
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
