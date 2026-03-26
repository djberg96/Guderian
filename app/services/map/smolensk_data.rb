module Map
  module SmolenskData
    FOREST_HEXES = %w[
      0112 0113 0117
      0202 0203 0212 0213 0217 0218 0224
    ].freeze

    ROAD_EXITS = {
      "0120" => %w[southwest]
    }.freeze

    RAILROAD_EXITS = {
      "0109" => %w[southeast],
      "0131" => %w[southwest],
      "0209" => %w[northeast],
      "0210" => %w[northeast southeast],
      "0228" => %w[northeast],
      "0229" => %w[southwest northeast],
      "0230" => %w[southwest]
    }.freeze

    HEXSIDE_FEATURES = [
      { hex_number: "0112", direction: "northeast", feature_type: "river" },
      { hex_number: "0120", direction: "northeast", feature_type: "river" },
      { hex_number: "0212", direction: "northeast", feature_type: "river" },
      { hex_number: "0219", direction: "northeast", feature_type: "river" }
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
