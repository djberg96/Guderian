Map::HexGridBuilder.rebuild!
Scenarios::DefaultForcesBuilder.rebuild!

sample_hexsides = [
  { hex_number: "1010", direction: "north", feature_type: "river" },
  { hex_number: "1011", direction: "northwest", feature_type: "river" },
  { hex_number: "1515", direction: "southeast", feature_type: "lake" }
]

sample_hexsides.each do |feature|
  HexsideFeature.create!(
    hex: Hex.find_by!(hex_number: feature.fetch(:hex_number)),
    direction: feature.fetch(:direction),
    feature_type: feature.fetch(:feature_type)
  )
end
