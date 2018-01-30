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
        if item.quality > 0
          update_sell_in(item)
        end

      else

        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == BACKSTAGE_PASS
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end
      end

      if item.name != SULFURAS
        item.sell_in = item.sell_in - 1
      end

      if item.sell_in < 0
        if item.name != AGED_BRIE
          if item.name != BACKSTAGE_PASS
            if item.quality > 0
              if item.name != SULFURAS
                item.quality = item.quality - 1
              end
            end
          else
            drop_backstage_pass_quality_after_concert(item)
          end
        else
          increase_brie_quality_after_SOD(item)
        end
      end
    end
  end
end

def update_sell_in(item)
  if item.name != "Sulfuras, Hand of Ragnaros"
    item.quality = item.quality - 1
  end
end

def drop_backstage_pass_quality_after_concert(item)
  item.quality = item.quality - item.quality
end

def increase_brie_quality_after_SOD(item)
  if item.quality < 50
    item.quality = item.quality + 1
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
