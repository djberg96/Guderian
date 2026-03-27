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
    chains.map { |points| build_flow_path(points) }.join(" ")
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

  def overlay_path_data(hex, directions, lateral_offset: 0.0, route_style: :generic)
    direction_list = Array(directions).map(&:to_s)
    special_path = special_route_path(hex, direction_list, lateral_offset:, route_style:)
    return special_path if special_path.present?

    if direction_list.length == 2
      return through_route_path(direction_list, lateral_offset:, route_style:)
    end

    direction_list.filter_map do |direction|
      start_point, midpoint = route_segment_points(direction, lateral_offset:)
      next unless start_point && midpoint

      format("M %.2f %.2f L %.2f %.2f", start_point[0], start_point[1], midpoint[0], midpoint[1])
    end.join(" ")
  end

  def railroad_tie_path_data(hex, directions, lateral_offset: 0.0)
    direction_list = Array(directions).map(&:to_s)
    special_ties = special_railroad_ties(hex, direction_list, lateral_offset:)
    return special_ties if special_ties.present?

    return through_route_ties(direction_list, lateral_offset:) if direction_list.length == 2

    direction_list.flat_map do |direction|
      start_point, midpoint = route_segment_points(direction, lateral_offset:)
      next [] unless start_point && midpoint

      tie_segments(start_point, midpoint)
    end.join(" ")
  end

  def route_lateral_offset(hex, feature_type)
    return 0.0 unless shared_route_lane?(hex)

    feature_type.to_s == "road" ? -4.0 : 4.0
  end

  private

  def special_route_path(hex, directions, lateral_offset:, route_style:)
    if route_style.to_sym == :railroad && hex.hex_number == "0618" && directions.sort == %w[northeast southwest]
      start_point = route_midpoint("southwest")
      end_point = transition_shifted_endpoint("southwest", "northeast", lateral_offset:)
      control_point = transition_control_point("southwest", "northeast", lateral_offset:, center_bias: 0.8)

      return format(
        "M %.2f %.2f Q %.2f %.2f %.2f %.2f",
        start_point[0], start_point[1],
        control_point[0], control_point[1],
        end_point[0], end_point[1]
      )
    end

    if route_style.to_sym == :road && hex.hex_number == "0617" && directions.sort == %w[southeast southwest]
      start_point = route_midpoint("southwest")
      end_point = transition_shifted_endpoint("southwest", "southeast", lateral_offset:)
      control_point = transition_control_point("southwest", "southeast", lateral_offset:, center_bias: 1.15)

      return format(
        "M %.2f %.2f Q %.2f %.2f %.2f %.2f",
        start_point[0], start_point[1],
        control_point[0], control_point[1],
        end_point[0], end_point[1]
      )
    end

    nil
  end

  def special_railroad_ties(hex, directions, lateral_offset:)
    return unless hex.hex_number == "0618"
    return unless directions.sort == %w[northeast southwest]

    start_point = route_midpoint("southwest")
    end_point = transition_shifted_endpoint("southwest", "northeast", lateral_offset:)
    tie_segments(start_point, end_point).join(" ")
  end

  def shared_route_lane?(hex)
    road_vector = route_axis_vector(hex.road_exits)
    rail_vector = route_axis_vector(hex.railroad_exits)
    return false unless road_vector && rail_vector

    angle = angle_between_vectors(road_vector, rail_vector)
    angle <= 40.0
  end

  def route_axis_vector(directions)
    direction_list = Array(directions).map(&:to_s)
    return nil if direction_list.empty?

    if direction_list.length == 1
      midpoint = route_midpoint(direction_list.first)
      return nil unless midpoint

      center = [32.0, 27.71]
      return [midpoint[0] - center[0], midpoint[1] - center[1]]
    end

    midpoints = direction_list.filter_map { |direction| route_midpoint(direction) }
    return nil unless midpoints.length >= 2

    [midpoints.last[0] - midpoints.first[0], midpoints.last[1] - midpoints.first[1]]
  end

  def angle_between_vectors(first_vector, second_vector)
    first_length = Math.sqrt((first_vector[0]**2) + (first_vector[1]**2))
    second_length = Math.sqrt((second_vector[0]**2) + (second_vector[1]**2))
    return 180.0 if first_length.zero? || second_length.zero?

    dot_product = (first_vector[0] * second_vector[0]) + (first_vector[1] * second_vector[1])
    cosine = dot_product / (first_length * second_length)
    cosine = [[cosine, -1.0].max, 1.0].min
    radians = Math.acos(cosine)
    degrees = radians * (180.0 / Math::PI)
    [degrees, 180.0 - degrees].min
  end

  OPPOSITE_DIRECTION_PAIRS = [
    %w[north south],
    %w[northeast southwest],
    %w[northwest southeast]
  ].map(&:sort).freeze

  def through_route_path(directions, lateral_offset:, route_style:)
    midpoints = directions.filter_map { |direction| route_midpoint(direction) }
    return "" unless midpoints.length == 2

    if route_style.to_sym == :road && !opposite_directions?(directions)
      start_point, end_point = apply_line_offset(midpoints[0], midpoints[1], lateral_offset)
      control_point = bend_control_point(directions, lateral_offset:)
      return format(
        "M %.2f %.2f Q %.2f %.2f %.2f %.2f",
        start_point[0], start_point[1],
        control_point[0], control_point[1],
        end_point[0], end_point[1]
      )
    end

    start_point, end_point = apply_line_offset(midpoints[0], midpoints[1], lateral_offset)
    format("M %.2f %.2f L %.2f %.2f", start_point[0], start_point[1], end_point[0], end_point[1])
  end

  def through_route_ties(directions, lateral_offset:)
    midpoints = directions.filter_map { |direction| route_midpoint(direction) }
    return "" unless midpoints.length == 2

    start_point, end_point = apply_line_offset(midpoints[0], midpoints[1], lateral_offset)
    tie_segments(start_point, end_point).join(" ")
  end

  def route_segment_points(direction, lateral_offset: 0.0)
    edge = EDGE_POINTS[direction.to_s]
    return unless edge

    start_point, end_point = edge
    center = [32.0, 27.71]
    midpoint = route_midpoint(direction)

    return [center, midpoint] if lateral_offset.zero?

    shift = perpendicular_offset(midpoint, center, lateral_offset)
    [
      [(center[0] + shift[0]).round(2), (center[1] + shift[1]).round(2)],
      [(midpoint[0] + shift[0]).round(2), (midpoint[1] + shift[1]).round(2)]
    ]
  end

  def route_midpoint(direction)
    start_point, end_point = EDGE_POINTS.fetch(direction.to_s)

    [
      (start_point[0] + end_point[0]) / 2.0,
      (start_point[1] + end_point[1]) / 2.0
    ]
  rescue KeyError
    nil
  end

  def perpendicular_offset(start_point, end_point, distance)
    dx = end_point[0] - start_point[0]
    dy = end_point[1] - start_point[1]
    length = Math.sqrt((dx**2) + (dy**2))
    return [0.0, 0.0] if length.zero?

    normal_x = -dy / length
    normal_y = dx / length
    [normal_x * distance, normal_y * distance]
  end

  def apply_line_offset(start_point, end_point, distance)
    return [start_point, end_point] if distance.zero?

    shift_x, shift_y = perpendicular_offset(start_point, end_point, distance)
    [
      [(start_point[0] + shift_x).round(2), (start_point[1] + shift_y).round(2)],
      [(end_point[0] + shift_x).round(2), (end_point[1] + shift_y).round(2)]
    ]
  end

  def opposite_directions?(directions)
    OPPOSITE_DIRECTION_PAIRS.include?(Array(directions).map(&:to_s).sort)
  end

  def bend_control_point(directions, lateral_offset:)
    center = [32.0, 27.71]
    shifts = Array(directions).filter_map do |direction|
      midpoint = route_midpoint(direction)
      next unless midpoint

      perpendicular_offset(midpoint, center, lateral_offset)
    end

    return center if shifts.empty?

    avg_x = shifts.sum { |shift| shift[0] } / shifts.length.to_f
    avg_y = shifts.sum { |shift| shift[1] } / shifts.length.to_f
    [(center[0] + avg_x).round(2), (center[1] + avg_y).round(2)]
  end

  def transition_shifted_endpoint(start_direction, end_direction, lateral_offset:)
    start_point = route_midpoint(start_direction)
    end_point = route_midpoint(end_direction)
    _, shifted_end = apply_line_offset(start_point, end_point, lateral_offset)
    shifted_end
  end

  def transition_control_point(start_direction, end_direction, lateral_offset:, center_bias:)
    center = [32.0, 27.71]
    start_point = route_midpoint(start_direction)
    end_point = route_midpoint(end_direction)
    shift_x, shift_y = perpendicular_offset(start_point, end_point, lateral_offset)

    [
      (center[0] + (shift_x * center_bias)).round(2),
      (center[1] + (shift_y * center_bias)).round(2)
    ]
  end

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

  def build_flow_path(points)
    return build_polyline_path(points) if points.length < 3

    path = [format("M %.2f %.2f", points.first[0], points.first[1])]

    points.each_cons(3).with_index do |(previous_point, current_point, next_point), index|
      control_point = flow_control_point(previous_point, current_point, next_point, index)
      midpoint = [
        ((current_point[0] + next_point[0]) / 2.0).round(2),
        ((current_point[1] + next_point[1]) / 2.0).round(2)
      ]

      if index.zero?
        first_midpoint = [
          ((previous_point[0] + current_point[0]) / 2.0).round(2),
          ((previous_point[1] + current_point[1]) / 2.0).round(2)
        ]
        path << format("Q %.2f %.2f %.2f %.2f", control_point[0], control_point[1], first_midpoint[0], first_midpoint[1])
      end

      path << format("Q %.2f %.2f %.2f %.2f", control_point[0], control_point[1], midpoint[0], midpoint[1])
    end

    penultimate = points[-2]
    last_point = points[-1]
    path << format("L %.2f %.2f", last_point[0], last_point[1]) if penultimate != last_point
    path.join(" ")
  end

  def flow_control_point(previous_point, current_point, next_point, index)
    bend_x = ((next_point[0] - previous_point[0]) * 0.18)
    bend_y = ((next_point[1] - previous_point[1]) * 0.18)
    sway = index.even? ? 1.0 : -1.0

    [
      (current_point[0] + (bend_y * 0.12 * sway)).round(2),
      (current_point[1] - (bend_x * 0.12 * sway)).round(2)
    ]
  end

  def point_key(point)
    format("%.2f,%.2f", point[0], point[1])
  end

  def point_from_key(key)
    x, y = key.split(",").map(&:to_f)
    [x, y]
  end
end
