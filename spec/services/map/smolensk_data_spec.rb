require "rails_helper"

RSpec.describe Map::SmolenskData do
  describe ".apply!" do
    it "applies the first row terrain, river, road, and railroad data" do
      Map::HexGridBuilder.rebuild!

      described_class.apply!

      expect(Hex.find_by!(hex_number: "0112").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0113").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0117").terrain_type).to eq("forest")

      river = HexsideFeature.find_by!(hex: Hex.find_by!(hex_number: "0112"), direction: "northeast", feature_type: "river")
      expect(river).to be_present

      second_river = HexsideFeature.find_by!(hex: Hex.find_by!(hex_number: "0120"), direction: "northeast", feature_type: "river")
      expect(second_river).to be_present

      expect(Hex.find_by!(hex_number: "0120").road_exits).to eq(%w[southwest])
      expect(Hex.find_by!(hex_number: "0109").railroad_exits).to eq(%w[southeast])
      expect(Hex.find_by!(hex_number: "0131").railroad_exits).to eq(%w[southwest])
    end
  end
end
