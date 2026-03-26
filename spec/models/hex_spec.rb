require "rails_helper"

RSpec.describe Hex, type: :model do
  describe "validations" do
    it "requires a four digit hex number" do
      hex = described_class.new(
        hex_number: "101",
        row: 1,
        column: 1,
        terrain_type: "clear",
        svg_x: 24.0,
        svg_y: 24.0
      )

      expect(hex).not_to be_valid
      expect(hex.errors[:hex_number]).to include("is invalid")
    end

    it "stores road exit directions as json-backed lists" do
      hex = described_class.new(
        hex_number: "0101",
        row: 1,
        column: 1,
        terrain_type: "clear",
        svg_x: 24.0,
        svg_y: 24.0
      )

      hex.road_exits = %w[north south]

      expect(hex.road_exits).to eq(%w[north south])
    end
  end
end
