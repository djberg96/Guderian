module Map
  module SmolenskData
    FOREST_HEXES = %w[
      0112 0113 0117
      0202 0203 0212 0213 0217 0218 0224
      0309 0312 0326
      0405 0406 0408 0409 0417 0422 0426 0427
    ].freeze

    TERRAIN_OVERRIDES = {
      "0412" => "major_city",
      "0513" => "major_city",
      "0420" => "minor_city",
      "0424" => "major_city",
      "0525" => "major_city"
    }.freeze

    ROAD_EXITS = {
      "0120" => %w[northwest northeast],
      "0219" => %w[southwest northeast],
      "0319" => %w[southwest]
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
      "0412" => %w[northwest north south],
      "0413" => %w[north south],
      "0414" => %w[north south],
      "0415" => %w[north south],
      "0416" => %w[north south],
      "0417" => %w[north south],
      "0418" => %w[north south],
      "0419" => %w[north south],
      "0420" => %w[north south],
      "0421" => %w[north southwest]
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
      { hex_number: "0331", direction: "northeast", feature_type: "river" }
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
