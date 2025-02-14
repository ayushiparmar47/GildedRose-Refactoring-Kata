require 'rspec'
require File.join(File.dirname(__FILE__), 'gilded_rose')

describe GildedRose do
  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    # Cases for Aged Brie
    describe "Quality case for Aged Brie" do
      it "it will increases quality as it gets older" do
        items = [Item.new("Aged Brie", 2, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "Aged Brie, 1, 1"
      end

      it "it will does not increase quality above 50" do
        items = [Item.new("Aged Brie", 5, 50)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "Aged Brie, 4, 50"
      end
    end

    # Cases for Backstage passes
    describe "Quality case for Backstage passes" do
      it "increases quality as sell_in approaches" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 11, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 10, 11"
      end

      it "it will increases quality by 2 when there are 10 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 9, 12"
      end

      it "it will increases quality by 3 when there are 5 days or less" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 4, 13"
      end

      it "it will does not increase quality above 50" do
        items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 4, 49)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "Backstage passes to a TAFKAL80ETC concert, 3, 50"
      end
    end

    # For ssulfuras it will not change anything
    describe "Quality case for Sulfuras" do
      it "it will does not change quality or sell_in" do
        items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 80)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "Sulfuras, Hand of Ragnaros, 0, 80"
      end
    end

    # Cases for conjured
    describe "Quality case with Conjured items" do
      it "degrades quality twice as fast as regular items" do
        items = [Item.new("Conjured Mana Cake", 5, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "Conjured Mana Cake, 4, 8"
      end

      it "it will degrades quality twice as fast after sell by date" do
        items = [Item.new("Conjured Mana Cake", 0, 10)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "Conjured Mana Cake, -1, 8"
      end

      it "it will not degrade quality below 0" do
        items = [Item.new("Conjured Mana Cake", 5, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "Conjured Mana Cake, 4, 0"
      end
    end

    describe "Quality case for other items" do
      it "it will degrades quality and sell_in by 1" do
        items = [Item.new("+5 Dexterity Vest",10 , 20)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "+5 Dexterity Vest, 9, 19"
      end

      it "it will does not degrade quality below 0" do
        items = [Item.new("Elixir of the Mongoose", 5, 0)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "Elixir of the Mongoose, 4, 0"
      end

      it "it will degrades quality twice as fast" do
        items = [Item.new("Elixir of the Mongoose", 0, 7)]
        GildedRose.new(items).update_quality
        expect(items[0].to_s).to eq "Elixir of the Mongoose, -1, 5"
      end
    end
  end
end
