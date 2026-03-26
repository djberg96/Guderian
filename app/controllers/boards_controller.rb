class BoardsController < ApplicationController
  def show
    @hexes = Hex.in_display_order
    @units = Unit.deployed.includes(:hex)
    @board_metrics = Map::HexGridBuilder.board_metrics
  end
end
