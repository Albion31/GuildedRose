# require File.join(File.dirname(__FILE__), './lib/gilded_rose')
require "spec_helper"

describe GildedRose do

  describe "#update_quality" do
    it "Does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "Reduces the quality and day of an item by 1 the following day" do
      items = [Item.new("butter", 10, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 9
      expect(items[0].quality).to eq 9
    end

    it "Once the sell by date has passed, Quality degrades twice as fast" do
      items = [Item.new("bread", 0, 10)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq (-1)
      expect(items[0].quality).to eq 8
    end

    it "The Quality of an item is never negative" do
      items = [Item.new("milk", 2, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 1
      expect(items[0].quality).to eq 0
    end

    it "'Aged Brie' actually increases in Quality the older it gets" do
      items = [Item.new("Aged Brie", 2, 12)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 1
      expect(items[0].quality).to eq 13
    end

    it "The Quality of an item is never more than 50 - 1st test" do
      items = [Item.new("Aged Brie", 10, 50)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 9
      expect(items[0].quality).to eq 50
    end

    it "The Quality of an item is never more than 50 - 2nd test" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 48)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 2
      expect(items[0].quality).to eq 50
    end

    it "'Sulfuras', being a legendary item, never has to be sold or decreases in Quality" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 10, 80)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 10
      expect(items[0].quality).to eq 80
    end

    it "'Backstage passes' increases in Quality by 2 when there are 10 days or less" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 7, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 6
      expect(items[0].quality).to eq 22
    end

    it "'Backstage passes' increases in Quality by 3 when there are 5 days or less" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 3, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq 2
      expect(items[0].quality).to eq 23
    end

    it "'Backstage passes' Quality drops to 0 after the concert" do
      items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 0, 20)]
      GildedRose.new(items).update_quality()
      expect(items[0].sell_in).to eq (-1)
      expect(items[0].quality).to eq 0
    end
  end
end
