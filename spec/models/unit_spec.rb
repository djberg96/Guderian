require "rails_helper"

RSpec.describe Unit, type: :model do
  describe "validations" do
    it "requires a supported side" do
      hex = Hex.create!(hex_number: "0101", row: 1, column: 1, terrain_type: "clear", svg_x: 24.0, svg_y: 24.0)
      unit = described_class.new(
        name: "Test Unit",
        side: "allied",
        unit_type: "infantry",
        attack_strength: 3,
        defense_strength: 3,
        movement_allowance: 4,
        hex: hex
      )

      expect(unit).not_to be_valid
      expect(unit.errors[:side]).to include("is not included in the list")
    end
  end
end
