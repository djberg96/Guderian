module Map
  module SmolenskData
    FOREST_HEXES = %w[
      0112 0113 0117
      0202 0203 0212 0213 0217 0218 0224
      0309 0312 0326
      0405 0406 0408 0409 0417 0422 0426 0427
      0505 0506 0507 0509 0512 0514 0515 0517 0518 0527 0528
      0606 0617 0628
      0710 0810 0816 0817 0917
      0721 0722 0723 0822 0823 0924
      0728 0729 0828 0829 0927 0929 0930 1027 1029 1129 1228 1229 1329 1330 1429
      0801 0901 0902
      1601 1701 1702 1801 1901 1902 2001 2101 2201 2301 2401 2501 2502 2601 2602 2701 2702
      1009 1010 1014 1109 1110 1111 1116 1118 1208 1209 1210 1216 1218
      1104 1105 1106 1203 1204 1205 1206 1304 1305
    ].freeze

    TERRAIN_OVERRIDES = {
      "0412" => "major_city",
      "0513" => "major_city",
      "0420" => "minor_city",
      "0424" => "major_city",
      "0525" => "major_city",
      "0802" => "swamp",
      "0708" => "swamp",
      "0808" => "swamp",
      "1006" => "swamp",
      "1107" => "swamp",
      "1310" => "swamp",
      "1512" => "swamp",
      "1612" => "swamp",
      "1613" => "swamp",
      "1804" => "swamp",
      "1805" => "swamp",
      "1905" => "swamp",
      "0615" => "swamp"
    }.freeze

    ROAD_EXITS = {
      "0501" => %w[northwest southeast],
      "0601" => %w[northwest southeast],
      "0702" => %w[northwest south],
      "0703" => %w[north south],
      "0704" => %w[north south],
      "0705" => %w[north south],
      "0706" => %w[north northeast],
      "0805" => %w[southwest southeast],
      "0906" => %w[northwest southeast],
      "1006" => %w[northwest southeast],
      "1107" => %w[northwest southeast],
      "1207" => %w[northwest southeast],
      "1308" => %w[northwest southeast],
      "1408" => %w[northwest],
      "0120" => %w[northwest northeast],
      "0219" => %w[southwest northeast],
      "0319" => %w[southwest northeast],
      "0418" => %w[southwest northeast],
      "0518" => %w[north southwest northeast],
      "0517" => %w[north south],
      "0516" => %w[north south],
      "0515" => %w[north south],
      "0514" => %w[north south],
      "0513" => %w[south northeast],
      "0612" => %w[southwest northeast],
      "0712" => %w[southwest northeast],
      "0811" => %w[southwest],
      "0617" => %w[southwest southeast],
      "0718" => %w[northwest northeast],
      "0817" => %w[southwest northeast],
      "0917" => %w[southwest northeast],
      "1016" => %w[southwest],
      "0911" => %w[northeast],
      "1010" => %w[southwest northeast],
      "1110" => %w[southwest northeast],
      "1209" => %w[southwest northeast],
      "1309" => %w[southwest southeast],
      "1409" => %w[northwest northeast],
      "1509" => %w[southwest]
    }.freeze

    RAILROAD_EXITS = {
      "0112" => %w[southeast],
      "0109" => %w[northwest southeast],
      "0131" => %w[northeast],
      "0209" => %w[northwest south],
      "0210" => %w[north southeast],
      "0212" => %w[northwest northeast],
      "0228" => %w[northeast south],
      "0229" => %w[north south],
      "0230" => %w[southwest north],
      "0311" => %w[northwest southeast],
      "0312" => %w[southwest southeast],
      "0322" => %w[northeast south],
      "0323" => %w[north south],
      "0324" => %w[north south],
      "0325" => %w[north south],
      "0326" => %w[north south],
      "0327" => %w[north south],
      "0328" => %w[southwest north],
      "0411" => %w[northwest south],
      "0412" => %w[northwest north south southeast],
      "0413" => %w[north south],
      "0414" => %w[north south],
      "0415" => %w[north south],
      "0416" => %w[north south],
      "0417" => %w[north south],
      "0418" => %w[north south],
      "0419" => %w[north south northeast],
      "0420" => %w[north south],
      "0421" => %w[north southwest],
      "0513" => %w[northwest southeast],
      "0519" => %w[southwest northeast],
      "0613" => %w[northwest southeast],
      "0618" => %w[southwest northeast],
      "0714" => %w[northwest southeast],
      "0718" => %w[southwest northeast],
      "0814" => %w[northwest southeast],
      "0817" => %w[southwest northeast],
      "0915" => %w[northwest southeast],
      "0917" => %w[southwest northeast],
      "1015" => %w[northwest],
      "1016" => %w[southwest]
    }.freeze

    HEXSIDE_FEATURES = [
      { hex_number: "0112", direction: "south", feature_type: "river" },
      { hex_number: "0113", direction: "northeast", feature_type: "river" },
      { hex_number: "0120", direction: "south", feature_type: "river" },
      { hex_number: "0120", direction: "southeast", feature_type: "river" },
      { hex_number: "0212", direction: "south", feature_type: "river" },
      { hex_number: "0219", direction: "south", feature_type: "river" },
      { hex_number: "0312", direction: "south", feature_type: "river" },
      { hex_number: "0313", direction: "northwest", feature_type: "river" },
      { hex_number: "0313", direction: "northeast", feature_type: "river" },
      { hex_number: "0413", direction: "northeast", feature_type: "river" },
      { hex_number: "0413", direction: "southeast", feature_type: "river" },
      { hex_number: "0414", direction: "northeast", feature_type: "river" },
      { hex_number: "0412", direction: "south", feature_type: "river" },
      { hex_number: "0412", direction: "southeast", feature_type: "river" },
      { hex_number: "0412", direction: "northeast", feature_type: "river" },
      { hex_number: "0411", direction: "southeast", feature_type: "river" },
      { hex_number: "0512", direction: "north", feature_type: "river" },
      { hex_number: "0511", direction: "southeast", feature_type: "river" },
      { hex_number: "0611", direction: "north", feature_type: "river" },
      { hex_number: "0610", direction: "southeast", feature_type: "river" },
      { hex_number: "0710", direction: "south", feature_type: "river" },
      { hex_number: "0711", direction: "northeast", feature_type: "river" },
      { hex_number: "0810", direction: "south", feature_type: "river" },
      { hex_number: "0810", direction: "southeast", feature_type: "river" },
      { hex_number: "0811", direction: "northeast", feature_type: "river" },
      { hex_number: "0911", direction: "south", feature_type: "river" },
      { hex_number: "0912", direction: "northeast", feature_type: "river" },
      { hex_number: "1011", direction: "south", feature_type: "river" },
      { hex_number: "1011", direction: "southeast", feature_type: "river" },
      { hex_number: "1111", direction: "south", feature_type: "river" },
      { hex_number: "1111", direction: "southeast", feature_type: "river" },
      { hex_number: "1210", direction: "south", feature_type: "river" },
      { hex_number: "1211", direction: "northeast", feature_type: "river" },
      { hex_number: "1311", direction: "south", feature_type: "river" },
      { hex_number: "1312", direction: "northeast", feature_type: "river" },
      { hex_number: "1411", direction: "south", feature_type: "river" },
      { hex_number: "1412", direction: "northeast", feature_type: "river" },
      { hex_number: "1512", direction: "south", feature_type: "river" },
      { hex_number: "1512", direction: "southeast", feature_type: "river" },
      { hex_number: "1611", direction: "south", feature_type: "river" },
      { hex_number: "1611", direction: "southeast", feature_type: "river" },
      { hex_number: "1513", direction: "northeast", feature_type: "river" },
      { hex_number: "1513", direction: "southeast", feature_type: "river" },
      { hex_number: "1514", direction: "northeast", feature_type: "river" },
      { hex_number: "1514", direction: "southeast", feature_type: "river" },
      { hex_number: "0320", direction: "southwest", feature_type: "river" },
      { hex_number: "0320", direction: "south", feature_type: "river" },
      { hex_number: "0325", direction: "southeast", feature_type: "river" },
      { hex_number: "0326", direction: "southeast", feature_type: "river" },
      { hex_number: "0326", direction: "northeast", feature_type: "river" },
      { hex_number: "0327", direction: "southeast", feature_type: "river" },
      { hex_number: "0327", direction: "northeast", feature_type: "river" },
      { hex_number: "0328", direction: "southeast", feature_type: "river" },
      { hex_number: "0328", direction: "northeast", feature_type: "river" },
      { hex_number: "0329", direction: "southeast", feature_type: "river" },
      { hex_number: "0329", direction: "northeast", feature_type: "river" },
      { hex_number: "0330", direction: "southeast", feature_type: "river" },
      { hex_number: "0330", direction: "northeast", feature_type: "river" },
      { hex_number: "0331", direction: "southeast", feature_type: "river" },
      { hex_number: "0331", direction: "northeast", feature_type: "river" },
      { hex_number: "0419", direction: "southeast", feature_type: "river" },
      { hex_number: "0420", direction: "southwest", feature_type: "river" },
      { hex_number: "0420", direction: "south", feature_type: "river" },
      { hex_number: "0420", direction: "southeast", feature_type: "river" },
      { hex_number: "0420", direction: "northeast", feature_type: "river" },
      { hex_number: "0421", direction: "southeast", feature_type: "river" },
      { hex_number: "0421", direction: "northeast", feature_type: "river" },
      { hex_number: "0422", direction: "southeast", feature_type: "river" },
      { hex_number: "0422", direction: "northeast", feature_type: "river" },
      { hex_number: "0423", direction: "southeast", feature_type: "river" },
      { hex_number: "0423", direction: "northeast", feature_type: "river" },
      { hex_number: "0424", direction: "south", feature_type: "river" },
      { hex_number: "0424", direction: "southeast", feature_type: "river" },
      { hex_number: "0424", direction: "northeast", feature_type: "river" },
      { hex_number: "0701", direction: "southeast", feature_type: "river" },
      { hex_number: "0702", direction: "northeast", feature_type: "river" },
      { hex_number: "0801", direction: "south", feature_type: "river" },
      { hex_number: "0802", direction: "northeast", feature_type: "river" },
      { hex_number: "0802", direction: "southeast", feature_type: "river" },
      { hex_number: "0803", direction: "northeast", feature_type: "river" },
      { hex_number: "0803", direction: "southeast", feature_type: "river" },
      { hex_number: "0803", direction: "south", feature_type: "river" },
      { hex_number: "0704", direction: "southeast", feature_type: "river" },
      { hex_number: "0705", direction: "northeast", feature_type: "river" },
      { hex_number: "0705", direction: "southeast", feature_type: "river" },
      { hex_number: "1601", direction: "south", feature_type: "river" },
      { hex_number: "1602", direction: "northeast", feature_type: "river" },
      { hex_number: "1702", direction: "south", feature_type: "river" },
      { hex_number: "1602", direction: "southeast", feature_type: "river" },
      { hex_number: "1603", direction: "northeast", feature_type: "river" },
      { hex_number: "1703", direction: "south", feature_type: "river" },
      { hex_number: "1704", direction: "northeast", feature_type: "river" },
      { hex_number: "1704", direction: "southeast", feature_type: "river" },
      { hex_number: "1705", direction: "northeast", feature_type: "river" },
      { hex_number: "1705", direction: "southeast", feature_type: "river" },
      { hex_number: "1706", direction: "northeast", feature_type: "river" },
      { hex_number: "1706", direction: "southeast", feature_type: "river" },
      { hex_number: "1707", direction: "northeast", feature_type: "river" },
      { hex_number: "1707", direction: "south", feature_type: "river" },
      { hex_number: "1707", direction: "southeast", feature_type: "river" },
      { hex_number: "1702", direction: "southeast", feature_type: "river" },
      { hex_number: "1801", direction: "south", feature_type: "river" },
      { hex_number: "1902", direction: "southwest", feature_type: "river" },
      { hex_number: "1902", direction: "south", feature_type: "river" },
      { hex_number: "1902", direction: "southeast", feature_type: "river" },
      { hex_number: "2001", direction: "south", feature_type: "river" },
      { hex_number: "2001", direction: "southeast", feature_type: "river" },
      { hex_number: "2101", direction: "south", feature_type: "river" },
      { hex_number: "2201", direction: "southwest", feature_type: "river" },
      { hex_number: "2201", direction: "south", feature_type: "river" },
      { hex_number: "2201", direction: "southeast", feature_type: "river" },
      { hex_number: "2301", direction: "south", feature_type: "river" },
      { hex_number: "2401", direction: "southwest", feature_type: "river" },
      { hex_number: "2401", direction: "south", feature_type: "river" },
      { hex_number: "2502", direction: "southwest", feature_type: "river" },
      { hex_number: "2502", direction: "south", feature_type: "river" },
      { hex_number: "2602", direction: "southwest", feature_type: "river" },
      { hex_number: "2602", direction: "south", feature_type: "river" },
      { hex_number: "2602", direction: "southeast", feature_type: "river" },
      { hex_number: "2701", direction: "southeast", feature_type: "river" },
      { hex_number: "2702", direction: "northeast", feature_type: "river" },
      { hex_number: "2702", direction: "southeast", feature_type: "river" },
      { hex_number: "2702", direction: "south", feature_type: "river" },
      { hex_number: "1607", direction: "northeast", feature_type: "river" },
      { hex_number: "1606", direction: "south", feature_type: "river" },
      { hex_number: "1507", direction: "southeast", feature_type: "river" },
      { hex_number: "1507", direction: "south", feature_type: "river" },
      { hex_number: "1407", direction: "southeast", feature_type: "river" },
      { hex_number: "1408", direction: "northeast", feature_type: "river" },
      { hex_number: "1408", direction: "southeast", feature_type: "river" },
      { hex_number: "1408", direction: "south", feature_type: "river" },
      { hex_number: "1309", direction: "northeast", feature_type: "river" },
      { hex_number: "1308", direction: "south", feature_type: "river" },
      { hex_number: "1208", direction: "southeast", feature_type: "river" },
      { hex_number: "1208", direction: "south", feature_type: "river" },
      { hex_number: "1109", direction: "southeast", feature_type: "river" },
      { hex_number: "1109", direction: "south", feature_type: "river" },
      { hex_number: "1009", direction: "southeast", feature_type: "river" },
      { hex_number: "1009", direction: "south", feature_type: "river" },
      { hex_number: "0910", direction: "southeast", feature_type: "river" },
      { hex_number: "0910", direction: "south", feature_type: "river" },
      { hex_number: "0810", direction: "northeast", feature_type: "river" },
      { hex_number: "0809", direction: "southeast", feature_type: "river" },
      { hex_number: "0909", direction: "south", feature_type: "river" },
      { hex_number: "0909", direction: "southeast", feature_type: "river" },
      { hex_number: "1008", direction: "south", feature_type: "river" },
      { hex_number: "1008", direction: "southeast", feature_type: "river" },
      { hex_number: "1008", direction: "northeast", feature_type: "river" },
      { hex_number: "1007", direction: "south", feature_type: "river" },
      { hex_number: "0908", direction: "northeast", feature_type: "river" },
      { hex_number: "0907", direction: "southeast", feature_type: "river" },
      { hex_number: "0602", direction: "north", feature_type: "lake" },
      { hex_number: "0602", direction: "northeast", feature_type: "lake" },
      { hex_number: "0602", direction: "southeast", feature_type: "lake" },
      { hex_number: "0602", direction: "south", feature_type: "lake" },
      { hex_number: "0602", direction: "southwest", feature_type: "lake" },
      { hex_number: "0602", direction: "northwest", feature_type: "lake" },
      { hex_number: "0907", direction: "northeast", feature_type: "lake" },
      { hex_number: "1502", direction: "north", feature_type: "lake" },
      { hex_number: "1502", direction: "northeast", feature_type: "lake" },
      { hex_number: "1502", direction: "southeast", feature_type: "lake" },
      { hex_number: "1502", direction: "south", feature_type: "lake" },
      { hex_number: "1502", direction: "southwest", feature_type: "lake" },
      { hex_number: "1502", direction: "northwest", feature_type: "lake" }
    ].freeze

    class << self
      def apply!
        apply_terrain_overrides!
        apply_route_overrides!
        apply_hexside_features!
      end

      private

      def apply_terrain_overrides!
        Hex.where(hex_number: FOREST_HEXES).update_all(terrain_type: "forest")

        TERRAIN_OVERRIDES.each do |hex_number, terrain_type|
          Hex.find_by!(hex_number: hex_number).update!(terrain_type:)
        end
      end

      def apply_route_overrides!
        ROAD_EXITS.each do |hex_number, directions|
          Hex.find_by!(hex_number: hex_number).update!(road_exits: directions)
        end

        RAILROAD_EXITS.each do |hex_number, directions|
          Hex.find_by!(hex_number: hex_number).update!(railroad_exits: directions)
        end
      end

      def apply_hexside_features!
        HexsideFeature.delete_all

        HEXSIDE_FEATURES.each do |feature|
          HexsideFeature.create!(
            hex: Hex.find_by!(hex_number: feature.fetch(:hex_number)),
            direction: feature.fetch(:direction),
            feature_type: feature.fetch(:feature_type)
          )
        end
      end

    end
  end
end
