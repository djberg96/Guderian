require "rails_helper"

RSpec.describe Map::SmolenskData do
  describe ".apply!" do
    it "applies the entered terrain, river, road, and railroad data for rows 01 and 02" do
      Map::HexGridBuilder.rebuild!

      described_class.apply!

      expect(Hex.find_by!(hex_number: "0112").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0113").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0117").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0202").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0203").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0212").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0213").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0217").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0218").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0224").terrain_type).to eq("forest")

      river = HexsideFeature.find_by!(hex: Hex.find_by!(hex_number: "0112"), direction: "south", feature_type: "river")
      expect(river).to be_present

      second_river = HexsideFeature.find_by!(hex: Hex.find_by!(hex_number: "0120"), direction: "south", feature_type: "river")
      expect(second_river).to be_present

      third_river = HexsideFeature.find_by!(hex: Hex.find_by!(hex_number: "0212"), direction: "south", feature_type: "river")
      expect(third_river).to be_present

      fourth_river = HexsideFeature.find_by!(hex: Hex.find_by!(hex_number: "0219"), direction: "south", feature_type: "river")
      expect(fourth_river).to be_present

      expect(Hex.find_by!(hex_number: "0120").road_exits).to eq(%w[northeast])
      expect(Hex.find_by!(hex_number: "0109").railroad_exits).to eq(%w[southeast])
      expect(Hex.find_by!(hex_number: "0131").railroad_exits).to eq(%w[northeast])
      expect(Hex.find_by!(hex_number: "0209").railroad_exits).to eq(%w[south])
      expect(Hex.find_by!(hex_number: "0210").railroad_exits).to eq(%w[north southeast])
      expect(Hex.find_by!(hex_number: "0228").railroad_exits).to eq(%w[south])
      expect(Hex.find_by!(hex_number: "0229").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0230").railroad_exits).to eq(%w[north])
    end
  end
end
