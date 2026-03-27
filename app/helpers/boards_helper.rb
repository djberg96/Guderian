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

  def river_path_data(hexes)
    river_features = hexes.flat_map(&:hexside_features).select { |feature| feature.feature_type == "river" }
    chains = merge_feature_segments(river_features.map { |feature| global_segment_points(feature) })
    chains.map { |points| build_polyline_path(points) }.join(" ")
  end

  def lake_path_data(hexes)
    lake_features = hexes.flat_map(&:hexside_features).select { |feature| feature.feature_type == "lake" }
    chains = merge_feature_segments(lake_features.map { |feature| global_segment_points(feature) })
    chains.map { |points| build_polyline_path(points) }.join(" ")
  end

  def full_lake_hex?(hex)
    lake_directions = hex.hexside_features.select { |feature| feature.feature_type == "lake" }.map(&:direction).sort
    lake_directions == Hex::EDGE_DIRECTIONS.sort
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

  def railroad_tie_path_data(directions)
    points = Array(directions).filter_map { |direction| EDGE_POINTS[direction.to_s] }
    center = [32.0, 27.71]

    points.flat_map do |(start_point, end_point)|
      midpoint = [
        ((start_point[0] + end_point[0]) / 2.0).round(2),
        ((start_point[1] + end_point[1]) / 2.0).round(2)
      ]

      tie_segments(center, midpoint)
    end.join(" ")
  end

  private

  def tie_segments(start_point, end_point)
    dx = end_point[0] - start_point[0]
    dy = end_point[1] - start_point[1]
    length = Math.sqrt((dx**2) + (dy**2))
    return [] if length.zero?

    unit_x = dx / length
    unit_y = dy / length
    normal_x = -unit_y
    normal_y = unit_x
    spacing = 8.0
    tie_length = 7.0
    offset = 7.0

    segments = []
    distance = offset

    while distance < (length - 4.0)
      anchor_x = start_point[0] + (unit_x * distance)
      anchor_y = start_point[1] + (unit_y * distance)
      half_tie = tie_length / 2.0
      x1 = anchor_x - (normal_x * half_tie)
      y1 = anchor_y - (normal_y * half_tie)
      x2 = anchor_x + (normal_x * half_tie)
      y2 = anchor_y + (normal_y * half_tie)

      segments << format("M %.2f %.2f L %.2f %.2f", x1, y1, x2, y2)
      distance += spacing
    end

    segments
  end

  def global_segment_points(feature)
    scale = Map::HexGridBuilder::HEX_HEIGHT / BASE_HEX_HEIGHT
    start_point, end_point = EDGE_POINTS.fetch(feature.direction)

    [
      [
        feature.hex.svg_x + (start_point[0] * scale),
        feature.hex.svg_y + (start_point[1] * scale)
      ],
      [
        feature.hex.svg_x + (end_point[0] * scale),
        feature.hex.svg_y + (end_point[1] * scale)
      ]
    ]
  end

  def merge_feature_segments(segments)
    adjacency = Hash.new { |hash, key| hash[key] = [] }
    segment_lookup = {}

    segments.each_with_index do |(start_point, end_point), index|
      start_key = point_key(start_point)
      end_key = point_key(end_point)
      segment_lookup[index] = { start: start_point, finish: end_point, start_key:, end_key: }
      adjacency[start_key] << index
      adjacency[end_key] << index
    end

    visited = {}
    chains = []

    segment_lookup.each_key do |segment_id|
      next if visited[segment_id]

      segment = segment_lookup.fetch(segment_id)
      start_key = [segment[:start_key], segment[:end_key]].find { |key| adjacency[key].length != 2 } || segment[:start_key]
      points = trace_chain(start_key, adjacency, segment_lookup, visited)
      chains << points if points.length >= 2
    end

    chains
  end

  def trace_chain(start_key, adjacency, segment_lookup, visited)
    current_key = start_key
    points = [point_from_key(start_key)]

    loop do
      next_segment_id = adjacency[current_key].find { |segment_id| !visited[segment_id] }
      break unless next_segment_id

      visited[next_segment_id] = true
      segment = segment_lookup.fetch(next_segment_id)
      next_key = segment[:start_key] == current_key ? segment[:end_key] : segment[:start_key]
      points << point_from_key(next_key)
      current_key = next_key
    end

    points
  end

  def build_polyline_path(points)
    first_point, *remaining_points = points
    move = format("M %.2f %.2f", first_point[0], first_point[1])
    lines = remaining_points.map { |point| format("L %.2f %.2f", point[0], point[1]) }
    ([move] + lines).join(" ")
  end

  def point_key(point)
    format("%.2f,%.2f", point[0], point[1])
  end

  def point_from_key(key)
    x, y = key.split(",").map(&:to_f)
    [x, y]
  end
end
