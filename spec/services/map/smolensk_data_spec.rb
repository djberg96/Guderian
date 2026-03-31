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
      expect(Hex.find_by!(hex_number: "2127").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2227").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2228").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2324").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2325").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2424").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2425").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2525").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2527").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2624").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2628").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2727").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2728").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2729").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2731").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2825").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2826").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2827").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2830").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2928").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2931").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2617").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2716").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2717").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2718").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2815").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2816").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2817").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2914").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3008").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3010").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3012").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3013").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3014").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3017").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3109").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3110").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3113").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3114").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3210").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3211").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3212").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3213").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3309").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3310").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3408").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3409").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3606").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3607").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3608").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3613").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3614").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3713").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3814").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3912").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3913").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "4017").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "4214").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3707").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3708").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2505").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2506").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2606").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2607").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2608").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2706").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2707").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2708").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2709").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2805").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2806").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2807").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "2808").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3002").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3003").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3025").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3123").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3125").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3126").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3127").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3103").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3104").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3203").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3226").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3302").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3304").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3403").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3404").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3503").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3504").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3602").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3603").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3703").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3705").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "3802").terrain_type).to eq("forest")
      expect(Hex.find_by!(hex_number: "0407").terrain_type).to eq("clear")
      expect(Hex.find_by!(hex_number: "0412").terrain_type).to eq("major_city")
      expect(Hex.find_by!(hex_number: "0513").terrain_type).to eq("major_city")
      expect(Hex.find_by!(hex_number: "0420").terrain_type).to eq("minor_city")
      expect(Hex.find_by!(hex_number: "0424").terrain_type).to eq("major_city")
      expect(Hex.find_by!(hex_number: "0525").terrain_type).to eq("major_city")
      expect(Hex.find_by!(hex_number: "3005").terrain_type).to eq("minor_city")
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
      expect(Hex.find_by!(hex_number: "2518").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "3416").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "2605").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "2904").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "2905").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "3004").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "3102").terrain_type).to eq("swamp")
      expect(Hex.find_by!(hex_number: "3201").terrain_type).to eq("swamp")

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

      expect(
        HexsideFeature.find_by(
          hex: Hex.find_by!(hex_number: "0420"),
          direction: "southwest",
          feature_type: "river"
        )
      ).to be_present

      expect(
        HexsideFeature.find_by(
          hex: Hex.find_by!(hex_number: "0420"),
          direction: "south",
          feature_type: "river"
        )
      ).to be_present

      expect(
        HexsideFeature.find_by(
          hex: Hex.find_by!(hex_number: "0413"),
          direction: "southeast",
          feature_type: "river"
        )
      ).to be_present

      expect(
        HexsideFeature.find_by(
          hex: Hex.find_by!(hex_number: "0413"),
          direction: "northeast",
          feature_type: "river"
        )
      ).to be_present

      expect(
        HexsideFeature.find_by(
          hex: Hex.find_by!(hex_number: "0414"),
          direction: "northeast",
          feature_type: "river"
        )
      ).to be_present

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

      [
        %w[1806 north],
        %w[1906 northwest],
        %w[1906 north],
        %w[2005 northwest],
        %w[2004 southwest],
        %w[2004 northwest],
        %w[2004 north],
        %w[2104 northwest],
        %w[2104 north],
        %w[2104 northeast],
        %w[2204 north],
        %w[2204 northeast],
        %w[2305 north],
        %w[2305 northeast],
        %w[2405 north],
        %w[2505 northwest],
        %w[2505 north],
        %w[2505 northeast],
        %w[2605 north],
        %w[2605 northeast],
        %w[2706 north],
        %w[2805 northwest],
        %w[2805 north],
        %w[2905 northwest],
        %w[2905 north],
        %w[2904 southwest],
        %w[2904 northwest],
        %w[2904 north],
        %w[3003 northwest],
        %w[3002 southwest],
        %w[3002 northwest],
        %w[3002 north],
        %w[3102 northwest],
        %w[3102 north],
        %w[3004 northwest],
        %w[3004 north],
        %w[3004 northeast],
        %w[3105 north],
        %w[3204 northwest],
        %w[3204 north],
        %w[3204 northeast],
        %w[3305 north],
        %w[3404 northwest],
        %w[3404 north],
        %w[3504 northwest],
        %w[3504 north],
        %w[3603 northwest],
        %w[3603 north]
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
        %w[1830 northeast],
        %w[1931 southwest],
        %w[1931 northwest],
        %w[1930 northwest],
        %w[1930 north],
        %w[1930 northeast],
        %w[2030 north],
        %w[2030 northeast],
        %w[2131 north],
        %w[2230 northwest],
        %w[2229 southwest],
        %w[2229 northwest],
        %w[2228 southwest],
        %w[2228 northwest],
        %w[2228 north],
        %w[2328 northwest],
        %w[2327 southwest],
        %w[2327 northwest],
        %w[2327 north],
        %w[2327 northeast],
        %w[2427 north],
        %w[2427 northeast],
        %w[2528 north],
        %w[2528 northeast],
        %w[2528 southeast],
        %w[2529 northeast],
        %w[2629 north],
        %w[2629 northeast],
        %w[2730 north],
        %w[2730 northeast],
        %w[2730 southeast],
        %w[2730 south],
        %w[2630 southeast],
        %w[2630 south],
        %w[2531 southeast],
        %w[2627 south],
        %w[2627 southeast],
        %w[2627 northeast],
        %w[2626 southeast],
        %w[2626 northeast],
        %w[2625 southeast],
        %w[2625 northeast],
        %w[2624 southeast]
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
        %w[3123 northwest],
        %w[3123 southwest],
        %w[3124 northwest],
        %w[3124 southwest],
        %w[3125 northwest],
        %w[3025 north],
        %w[3025 northwest],
        %w[3025 southwest],
        %w[3025 south],
        %w[3126 southwest],
        %w[3127 northwest],
        %w[3127 southwest],
        %w[3128 north],
        %w[3227 southwest],
        %w[3228 northwest],
        %w[3228 southwest],
        %w[3228 south],
        %w[3228 southeast],
        %w[3328 south],
        %w[3328 southeast],
        %w[3328 northeast],
        %w[3327 southeast],
        %w[3327 northeast],
        %w[3329 southwest],
        %w[3330 northwest],
        %w[3330 southwest],
        %w[3330 south],
        %w[3430 southwest],
        %w[3431 northwest]
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
        %w[2817 north],
        %w[2917 northwest],
        %w[2917 north],
        %w[2917 northeast],
        %w[3017 north],
        %w[3017 northeast],
        %w[3118 north],
        %w[3217 northwest],
        %w[3217 north],
        %w[3317 northwest],
        %w[3317 north],
        %w[3416 northwest],
        %w[3415 southwest],
        %w[3415 northwest],
        %w[3414 southwest],
        %w[3414 northwest],
        %w[3414 north],
        %w[3514 northwest],
        %w[3513 southwest],
        %w[3513 northwest],
        %w[3512 southwest],
        %w[3512 northwest],
        %w[3511 southwest],
        %w[3511 northwest],
        %w[3510 southwest],
        %w[3510 northwest],
        %w[3509 southwest],
        %w[3509 northwest],
        %w[3509 north],
        %w[3509 northeast],
        %w[3609 north],
        %w[3709 northwest],
        %w[3708 southwest],
        %w[3707 southwest],
        %w[3707 northwest],
        %w[3706 southwest],
        %w[3706 northwest],
        %w[3705 southwest]
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
      expect(Hex.find_by!(hex_number: "1016").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1110").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1116").road_exits).to eq(%w[southwest southeast])
      expect(Hex.find_by!(hex_number: "1216").road_exits).to eq(%w[northwest northeast])
      expect(Hex.find_by!(hex_number: "1316").road_exits).to eq(%w[southwest southeast])
      expect(Hex.find_by!(hex_number: "1416").road_exits).to eq(%w[northwest northeast])
      expect(Hex.find_by!(hex_number: "1516").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1615").road_exits).to eq(%w[southwest southeast])
      expect(Hex.find_by!(hex_number: "1716").road_exits).to eq(%w[northwest northeast])
      expect(Hex.find_by!(hex_number: "1815").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1915").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1209").road_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1309").road_exits).to eq(%w[southwest southeast])
      expect(Hex.find_by!(hex_number: "1409").road_exits).to eq(%w[northwest northeast])
      expect(Hex.find_by!(hex_number: "1509").road_exits).to eq(%w[southwest])
      expect(Hex.find_by!(hex_number: "2626").road_exits).to eq(%w[north])
      expect(Hex.find_by!(hex_number: "2625").road_exits).to eq(%w[south northwest])
      expect(Hex.find_by!(hex_number: "2525").road_exits).to eq(%w[southeast north])
      expect(Hex.find_by!(hex_number: "2524").road_exits).to eq(%w[south northwest])
      expect(Hex.find_by!(hex_number: "2423").road_exits).to eq(%w[southeast north])
      expect(Hex.find_by!(hex_number: "2422").road_exits).to eq(%w[south north])
      expect(Hex.find_by!(hex_number: "2421").road_exits).to eq(%w[south northwest])
      expect(Hex.find_by!(hex_number: "2321").road_exits).to eq(%w[southeast north])
      expect(Hex.find_by!(hex_number: "2320").road_exits).to eq(%w[south northwest])
      expect(Hex.find_by!(hex_number: "2219").road_exits).to eq(%w[southeast north])
      expect(Hex.find_by!(hex_number: "2218").road_exits).to eq(%w[south north])
      expect(Hex.find_by!(hex_number: "2217").road_exits).to eq(%w[south])
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
      expect(Hex.find_by!(hex_number: "0420").railroad_exits).to eq(%w[north south southeast])
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
      expect(Hex.find_by!(hex_number: "1016").railroad_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1116").railroad_exits).to eq(%w[southwest southeast])
      expect(Hex.find_by!(hex_number: "1216").railroad_exits).to eq(%w[northwest northeast])
      expect(Hex.find_by!(hex_number: "1316").railroad_exits).to eq(%w[southwest southeast])
      expect(Hex.find_by!(hex_number: "1416").railroad_exits).to eq(%w[northwest northeast])
      expect(Hex.find_by!(hex_number: "1516").railroad_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1615").railroad_exits).to eq(%w[southwest southeast])
      expect(Hex.find_by!(hex_number: "1716").railroad_exits).to eq(%w[northwest northeast])
      expect(Hex.find_by!(hex_number: "1815").railroad_exits).to eq(%w[southwest northeast])
      expect(Hex.find_by!(hex_number: "1915").railroad_exits).to eq(%w[southwest])
    end
  end
end
