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
      expect(Hex.find_by!(hex_number: "0309").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0312").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0326").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0405").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0406").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0408").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0409").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0417").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0422").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0426").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0427").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0407").terrain_type).to eq("clear")
      expect(Hex.find_by!(hex_number: "0412").terrain_type).to eq("major_city")
      expect(Hex.find_by!(hex_number: "0513").terrain_type).to eq("major_city")
      expect(Hex.find_by!(hex_number: "0420").terrain_type).to eq("minor_city")
      expect(Hex.find_by!(hex_number: "0424").terrain_type).to eq("major_city")
      expect(Hex.find_by!(hex_number: "0525").terrain_type).to eq("major_city")

      river = HexsideFeature.find_by!(hex: Hex.find_by!(hex_number: "0112"), direction: "south", feature_type: "river")
      expect(river).to be_present

      diagonal_river = HexsideFeature.find_by!(hex: Hex.find_by!(hex_number: "0113"), direction: "northeast", feature_type: "river")
      expect(diagonal_river).to be_present

      second_river = HexsideFeature.find_by!(hex: Hex.find_by!(hex_number: "0120"), direction: "south", feature_type: "river")
      expect(second_river).to be_present

      southeast_river = HexsideFeature.find_by!(hex: Hex.find_by!(hex_number: "0120"), direction: "southeast", feature_type: "river")
      expect(southeast_river).to be_present

      third_river = HexsideFeature.find_by!(hex: Hex.find_by!(hex_number: "0212"), direction: "south", feature_type: "river")
      expect(third_river).to be_present

      fourth_river = HexsideFeature.find_by!(hex: Hex.find_by!(hex_number: "0219"), direction: "south", feature_type: "river")
      expect(fourth_river).to be_present

      river_0312_0313 = HexsideFeature.find_by!(
        hex: Hex.find_by!(hex_number: "0312"),
        direction: "south",
        feature_type: "river"
      )
      expect(river_0312_0313).to be_present

      river_0313_0212 = HexsideFeature.find_by!(
        hex: Hex.find_by!(hex_number: "0313"),
        direction: "northwest",
        feature_type: "river"
      )
      expect(river_0313_0212).to be_present

      southwest_river = HexsideFeature.find_by!(
        hex: Hex.find_by!(hex_number: "0320"),
        direction: "southwest",
        feature_type: "river"
      )
      expect(southwest_river).to be_present

      south_river = HexsideFeature.find_by!(
        hex: Hex.find_by!(hex_number: "0320"),
        direction: "south",
        feature_type: "river"
      )
      expect(south_river).to be_present

      kink_river = HexsideFeature.find_by!(
        hex: Hex.find_by!(hex_number: "0325"),
        direction: "southeast",
        feature_type: "river"
      )
      expect(kink_river).to be_present

      %w[0326 0327 0328 0329 0330 0331].each do |hex_number|
        southeast_river = HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: hex_number),
          direction: "southeast",
          feature_type: "river"
        )
        expect(southeast_river).to be_present

        east_bank_river = HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: hex_number),
          direction: "northeast",
          feature_type: "river"
        )
        expect(east_bank_river).to be_present
      end

      expect(Hex.find_by!(hex_number: "0120").road_exits).to eq(%w[northwest northeast])
      expect(Hex.find_by!(hex_number: "0219").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "0319").road_exits).to eq(%w[southwest])
      expect(Hex.find_by!(hex_number: "0112").railroad_exits).to eq(%w[southeast])
      expect(Hex.find_by!(hex_number: "0109").railroad_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "0131").railroad_exits).to eq(%w[northeast])
      expect(Hex.find_by!(hex_number: "0209").railroad_exits).to eq(%w[northwest south])
      expect(Hex.find_by!(hex_number: "0210").railroad_exits).to eq(%w[north southeast])
      expect(Hex.find_by!(hex_number: "0212").railroad_exits).to eq(%w[northwest northeast])
      expect(Hex.find_by!(hex_number: "0228").railroad_exits).to eq(%w[northeast south])
      expect(Hex.find_by!(hex_number: "0229").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0230").railroad_exits).to eq(%w[southwest north])
      expect(Hex.find_by!(hex_number: "0311").railroad_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "0312").railroad_exits).to eq(%w[southwest southeast])
      expect(Hex.find_by!(hex_number: "0313").railroad_exits).to eq([])
      expect(Hex.find_by!(hex_number: "0322").railroad_exits).to eq(%w[northeast south])
      expect(Hex.find_by!(hex_number: "0323").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0324").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0325").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0326").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0327").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0328").railroad_exits).to eq(%w[southwest north])
      expect(Hex.find_by!(hex_number: "0411").railroad_exits).to eq(%w[northwest south])
      expect(Hex.find_by!(hex_number: "0412").railroad_exits).to eq(%w[northwest north south])
      expect(Hex.find_by!(hex_number: "0413").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0414").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0415").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0416").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0417").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0418").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0419").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0420").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0421").railroad_exits).to eq(%w[north southwest])
    end
  end
end
