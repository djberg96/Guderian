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
      expect(Hex.find_by!(hex_number: "0505").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0506").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0507").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0509").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0512").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0514").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0515").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0517").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0518").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0527").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0528").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0606").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0617").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0628").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0710").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0721").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0722").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0723").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0728").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0729").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0801").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0822").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0823").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0828").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0829").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0810").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0816").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0817").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0901").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0902").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0927").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0924").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0929").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0930").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0917").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1027").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1009").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1010").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1014").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1029").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1104").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1105").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1106").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1109").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1110").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1111").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1116").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1118").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1129").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1203").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1204").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1205").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1206").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1208").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1209").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1210").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1216").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1218").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1228").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1229").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1304").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1305").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1329").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1330").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "1429").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0407").terrain_type).to eq("clear")
      expect(Hex.find_by!(hex_number: "0412").terrain_type).to eq("major_city")
      expect(Hex.find_by!(hex_number: "0513").terrain_type).to eq("major_city")
      expect(Hex.find_by!(hex_number: "0420").terrain_type).to eq("minor_city")
      expect(Hex.find_by!(hex_number: "0424").terrain_type).to eq("major_city")
      expect(Hex.find_by!(hex_number: "0525").terrain_type).to eq("major_city")
      expect(Hex.find_by!(hex_number: "0602").terrain_type).to eq("clear")
      expect(Hex.find_by!(hex_number: "0615").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "0708").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "0802").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "0808").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "1006").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "1107").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "1310").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "1512").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "1612").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "1613").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "1804").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "1805").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "1905").terrain_type).to eq("swamp")

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

      [
        %w[0313 northeast],
        %w[0412 south],
        %w[0412 southeast],
        %w[0412 northeast],
        %w[0411 southeast],
        %w[0512 north],
        %w[0511 southeast],
        %w[0611 north],
        %w[0610 southeast],
        %w[0710 south],
        %w[0711 northeast],
        %w[0810 south],
        %w[0810 southeast]
      ].each do |hex_number, direction|
        expect(
          HexsideFeature.find_by!(
            hex: Hex.find_by!(hex_number: hex_number),
            direction: direction,
            feature_type: "river"
          )
        ).to be_present
      end

      [
        %w[0811 northeast],
        %w[0911 south],
        %w[0912 northeast],
        %w[1011 south],
        %w[1011 southeast],
        %w[1111 south],
        %w[1111 southeast],
        %w[1210 south],
        %w[1211 northeast],
        %w[1311 south],
        %w[1312 northeast],
        %w[1411 south],
        %w[1412 northeast],
        %w[1512 south],
        %w[1512 southeast],
        %w[1611 south],
        %w[1611 southeast],
        %w[1513 northeast],
        %w[1513 southeast],
        %w[1514 northeast],
        %w[1514 southeast]
      ].each do |hex_number, direction|
        expect(
          HexsideFeature.find_by!(
            hex: Hex.find_by!(hex_number: hex_number),
            direction: direction,
            feature_type: "river"
          )
        ).to be_present
      end

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

      river_0424_0425 = HexsideFeature.find_by!(
        hex: Hex.find_by!(hex_number: "0424"),
        direction: "south",
        feature_type: "river"
      )
      expect(river_0424_0425).to be_present

      snake_0419_southeast = HexsideFeature.find_by!(
        hex: Hex.find_by!(hex_number: "0419"),
        direction: "southeast",
        feature_type: "river"
      )
      expect(snake_0419_southeast).to be_present

      expect(
        HexsideFeature.find_by(
          hex: Hex.find_by!(hex_number: "0419"),
          direction: "northeast",
          feature_type: "river"
        )
      ).to be_nil

      %w[0420 0421 0422 0423 0424].each do |hex_number|
        snake_southeast = HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: hex_number),
          direction: "southeast",
          feature_type: "river"
        )
        expect(snake_southeast).to be_present

        snake_northeast = HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: hex_number),
          direction: "northeast",
          feature_type: "river"
        )
        expect(snake_northeast).to be_present
      end

      %w[north northeast southeast south southwest northwest].each do |direction|
        lake_edge = HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0602"),
          direction: direction,
          feature_type: "lake"
        )
        expect(lake_edge).to be_present
      end

      expect(Hex.find_by!(hex_number: "1502").terrain_type).to eq("clear")

      %w[north northeast southeast south southwest northwest].each do |direction|
        lake_edge = HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "1502"),
          direction: direction,
          feature_type: "lake"
        )
        expect(lake_edge).to be_present
      end

      expect(
        HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0907"),
          direction: "northeast",
          feature_type: "lake"
        )
      ).to be_present

      expect(
        HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0701"),
          direction: "southeast",
          feature_type: "river"
        )
      ).to be_present
      expect(
        HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0702"),
          direction: "northeast",
          feature_type: "river"
        )
      ).to be_present
      expect(
        HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0801"),
          direction: "south",
          feature_type: "river"
        )
      ).to be_present
      expect(
        HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0802"),
          direction: "northeast",
          feature_type: "river"
        )
      ).to be_present
      expect(
        HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0802"),
          direction: "southeast",
          feature_type: "river"
        )
      ).to be_present
      expect(
        HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0803"),
          direction: "northeast",
          feature_type: "river"
        )
      ).to be_present
      expect(
        HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0803"),
          direction: "southeast",
          feature_type: "river"
        )
      ).to be_present
      expect(
        HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0803"),
          direction: "south",
          feature_type: "river"
        )
      ).to be_present
      expect(
        HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0704"),
          direction: "southeast",
          feature_type: "river"
        )
      ).to be_present
      expect(
        HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0705"),
          direction: "northeast",
          feature_type: "river"
        )
      ).to be_present
      expect(
        HexsideFeature.find_by!(
          hex: Hex.find_by!(hex_number: "0705"),
          direction: "southeast",
          feature_type: "river"
        )
      ).to be_present

      [
        %w[1601 south],
        %w[1602 northeast],
        %w[1702 south],
        %w[1602 southeast],
        %w[1603 northeast],
        %w[1703 south],
        %w[1704 northeast],
        %w[1704 southeast],
        %w[1705 northeast],
        %w[1705 southeast],
        %w[1706 northeast],
        %w[1706 southeast],
        %w[1707 northeast],
        %w[1707 south],
        %w[1707 southeast],
        %w[1607 northeast],
        %w[1606 south],
        %w[1507 southeast],
        %w[1507 south],
        %w[1407 southeast],
        %w[1408 northeast],
        %w[1408 southeast],
        %w[1408 south],
        %w[1309 northeast],
        %w[1308 south],
        %w[1208 southeast],
        %w[1208 south],
        %w[1109 southeast],
        %w[1109 south],
        %w[1009 southeast],
        %w[1009 south],
        %w[0910 southeast],
        %w[0910 south],
        %w[0810 northeast],
        %w[0809 southeast],
        %w[0909 south],
        %w[0909 southeast],
        %w[1008 south],
        %w[1008 southeast],
        %w[1008 northeast],
        %w[1007 south],
        %w[0908 northeast],
        %w[0907 southeast]
      ].each do |hex_number, direction|
        expect(
          HexsideFeature.find_by!(
            hex: Hex.find_by!(hex_number: hex_number),
            direction: direction,
            feature_type: "river"
          )
        ).to be_present
      end

      expect(Hex.find_by!(hex_number: "0501").road_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "0601").road_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "0702").road_exits).to eq(%w[northwest south])
      expect(Hex.find_by!(hex_number: "0703").road_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0704").road_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0705").road_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0706").road_exits).to eq(%w[north northeast])
      expect(Hex.find_by!(hex_number: "0805").road_exits).to eq(%w[southwest southeast])
      expect(Hex.find_by!(hex_number: "0906").road_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "1006").road_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "1107").road_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "1207").road_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "1308").road_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "1408").road_exits).to eq(%w[northwest])
      expect(Hex.find_by!(hex_number: "0120").road_exits).to eq(%w[northwest northeast])
      expect(Hex.find_by!(hex_number: "0219").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "0319").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "0418").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "0518").road_exits).to eq(%w[north southwest northeast])
      expect(Hex.find_by!(hex_number: "0517").road_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0516").road_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0515").road_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0514").road_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0513").road_exits).to eq(%w[south northeast])
      expect(Hex.find_by!(hex_number: "0612").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "0712").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "0811").road_exits).to eq(%w[southwest])
      expect(Hex.find_by!(hex_number: "0617").road_exits).to eq(%w[southwest southeast])
      expect(Hex.find_by!(hex_number: "0718").road_exits).to eq(%w[northwest northeast])
      expect(Hex.find_by!(hex_number: "0817").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "0911").road_exits).to eq(%w[northeast])
      expect(Hex.find_by!(hex_number: "0917").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1010").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1016").road_exits).to eq(%w[southwest])
      expect(Hex.find_by!(hex_number: "1110").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1209").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1309").road_exits).to eq(%w[southwest southeast])
      expect(Hex.find_by!(hex_number: "1409").road_exits).to eq(%w[northwest northeast])
      expect(Hex.find_by!(hex_number: "1509").road_exits).to eq(%w[southwest])
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
      expect(Hex.find_by!(hex_number: "0412").railroad_exits).to eq(%w[northwest north south southeast])
      expect(Hex.find_by!(hex_number: "0413").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0414").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0415").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0416").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0417").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0418").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0419").railroad_exits).to eq(%w[north south northeast])
      expect(Hex.find_by!(hex_number: "0420").railroad_exits).to eq(%w[north south])
      expect(Hex.find_by!(hex_number: "0421").railroad_exits).to eq(%w[north southwest])
      expect(Hex.find_by!(hex_number: "0513").railroad_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "0519").railroad_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "0613").railroad_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "0618").railroad_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "0714").railroad_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "0718").railroad_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "0814").railroad_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "0817").railroad_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "0915").railroad_exits).to eq(%w[northwest southeast])
      expect(Hex.find_by!(hex_number: "0917").railroad_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1015").railroad_exits).to eq(%w[northwest])
      expect(Hex.find_by!(hex_number: "1016").railroad_exits).to eq(%w[southwest])
    end
  end
end
