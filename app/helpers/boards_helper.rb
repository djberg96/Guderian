module BoardsHelper
  BASE_HEX_WIDTH = 64.0
  BASE_HEX_HEIGHT = 55.43
  EDGE_POINTS = {
    "north" => [[16.0, 0.0], [48.0, 0.0]],
    "northeast" => [[48.0, 0.0], [64.0, 27.71]],
    "southeast" => [[64.0, 27.71], [48.0, 55.43]],
    "south" => [[48.0, 55.43], [16.0, 55.43]],
    "southwest" => [[16.0, 55.43], [0.0, 27.71]],
    "northwest" => [[0.0, 27.71], [16.0, 0.0]]
  }.freeze

  def flat_top_hex_points(hex, size: Map::HexGridBuilder::HEX_SIZE)
    x = hex.svg_x
    y = hex.svg_y
    half_width = size
    quarter_width = size / 2.0
    half_height = Map::HexGridBuilder::HEX_HEIGHT / 2.0

    [
      [x + quarter_width, y],
      [x + quarter_width + half_width, y],
      [x + (2 * half_width), y + half_height],
      [x + quarter_width + half_width, y + Map::HexGridBuilder::HEX_HEIGHT],
      [x + quarter_width, y + Map::HexGridBuilder::HEX_HEIGHT],
      [x, y + half_height]
    ].map { |point_x, point_y| format("%.2f,%.2f", point_x, point_y) }.join(" ")
  end

  def counter_position(unit)
    metrics = counter_metrics

    {
      x: unit.hex.svg_x + ((Map::HexGridBuilder::HEX_WIDTH - metrics[:width]) / 2.0),
      y: unit.hex.svg_y + ((Map::HexGridBuilder::HEX_HEIGHT - metrics[:height]) / 2.0)
    }
  end

  def asset_href(logical_path)
    ActionController::Base.helpers.asset_path(logical_path)
  end

  def counter_metrics
    {
      width: (Map::HexGridBuilder::HEX_WIDTH * 0.72).round(2),
      height: (Map::HexGridBuilder::HEX_HEIGHT * 0.54).round(2),
      corner_radius: (Map::HexGridBuilder::HEX_HEIGHT * 0.07).round(2),
      name_y: (Map::HexGridBuilder::HEX_HEIGHT * 0.22).round(2),
      stats_y: (Map::HexGridBuilder::HEX_HEIGHT * 0.42).round(2),
      center_x: (Map::HexGridBuilder::HEX_WIDTH * 0.36).round(2)
    }
  end

  def hex_overlay_transform(hex)
    scale = Map::HexGridBuilder::HEX_HEIGHT / BASE_HEX_HEIGHT
    "translate(#{hex.svg_x} #{hex.svg_y}) scale(#{format('%.5f', scale)})"
  end

  def overlay_path_data(directions)
    points = Array(directions).filter_map { |direction| EDGE_POINTS[direction.to_s] }
    center = [32.0, 27.71]

    points.map do |(start_point, end_point)|
      midpoint = [
        ((start_point[0] + end_point[0]) / 2.0).round(2),
        ((start_point[1] + end_point[1]) / 2.0).round(2)
      ]
      "M #{center[0]} #{center[1]} L #{midpoint[0]} #{midpoint[1]}"
    end.join(" ")
  end
end
