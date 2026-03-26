require "rails_helper"

RSpec.describe "Boards", type: :request do
  describe "GET /" do
    it "shows the board" do
      hex = Hex.create!(
        hex_number: "0101",
        row: 1,
        column: 1,
        terrain_type: "clear",
        svg_x: 24.0,
        svg_y: 24.0
      )
      Unit.create!(
        name: "7th Panzer",
        side: "german",
        unit_type: "armor",
        attack_strength: 8,
        defense_strength: 6,
        movement_allowance: 8,
        hex: hex
      )

      get root_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Guderian")
      expect(response.body).to include("0101")
      expect(response.body).to include("German")
      expect(response.body).to include("Soviet")
      expect(response.body).to include("Map zoom controls")
      expect(response.body).not_to include("7th Panzer")
    end
  end
end
