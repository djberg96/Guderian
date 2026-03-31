module BoardsHelper
  BASE_HEX_WIDTH = 64.0
  BASE_HEX_HEIGHT = 55.43
  FOREST_BRIDGE_DIRECTIONS = %w[south northeast southeast].freeze
  EDGE_POINTS = {
    "north" => [[16.0, 0.0], [48.0, 0.0]],
    "northeast" => [[48.0, 0.0], [64.0, 27.71]],
    "southeast" => [[64.0, 27.71], [48.0, 55.43]],
    "south" => [[48.0, 55.43], [16.0, 55.43]],
    "southwest" => [[16.0, 55.43], [0.0, 27.71]],
    "northwest" => [[0.0, 27.71], [16.0, 0.0]]
  }.freeze
  OPPOSITE_DIRECTIONS = {
    "north" => "south",
    "northeast" => "southwest",
    "southeast" => "northwest",
    "south" => "north",
    "southwest" => "northeast",
    "northwest" => "southeast"
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

  CITY_LABELS = [
    { text: "Vitebsk", hex_numbers: %w[0412 0513], x_ratio: 0.88, y_ratio: 0.56 },
    { text: "Orsha", hex_numbers: %w[0420], x_ratio: 0.04, y_ratio: 0.28 },
    { text: "Mogilev", hex_numbers: %w[0424 0525], x_ratio: 0.94, y_ratio: 0.48 },
    { text: "Krichev", hex_numbers: %w[1427], x_ratio: 0.62, y_ratio: 0.6 },
    { text: "Mstislavl", hex_numbers: %w[1524], x_ratio: 0.68, y_ratio: 0.56 },
    { text: "SMOLENSK", hex_numbers: %w[2216 2217], x_ratio: -0.5, y_ratio: 0.54, variant: :major },
    { text: "Belyy", hex_numbers: %w[3005], x_ratio: 0.64, y_ratio: 0.58 },
    { text: "Roslavl", hex_numbers: %w[2626], x_ratio: 0.6, y_ratio: 0.62 }
  ].freeze

  def city_labels(hexes)
    hex_lookup = hexes.index_by(&:hex_number)

    CITY_LABELS.filter_map do |label|
      anchor_hexes = label[:hex_numbers].filter_map { |hex_number| hex_lookup[hex_number] }
      next if anchor_hexes.empty?

      min_x = anchor_hexes.map(&:svg_x).min
      max_x = anchor_hexes.map(&:svg_x).max
      min_y = anchor_hexes.map(&:svg_y).min
      max_y = anchor_hexes.map(&:svg_y).max
      anchor_width = (max_x - min_x) + Map::HexGridBuilder::HEX_WIDTH
      anchor_height = (max_y - min_y) + Map::HexGridBuilder::HEX_HEIGHT

      {
        text: label[:text],
        x: (min_x + (anchor_width * label[:x_ratio])).round(2),
        y: (min_y + (anchor_height * label[:y_ratio])).round(2),
        variant: label[:variant]
      }
    end
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

    return through_route_ties(direction_list, lateral_offset:, route_style: :railroad) if direction_list.length == 2

    direction_list.flat_map do |direction|
      start_point, midpoint = route_segment_points(direction, lateral_offset:)
      next [] unless start_point && midpoint

      tie_segments(start_point, midpoint)
    end.join(" ")
  end

  def route_lateral_offset(hex, feature_type)
    return 0.0 unless shared_route_lane?(hex)
    return 0.0 if feature_type.to_s == "road" && hex.road_exits.one?

    feature_type.to_s == "road" ? -7.0 : 7.0
  end

  FOREST_BRIDGE_COLORS = ["#6f8756", "#556c41", "#7f9864"].freeze

  def forest_bridge_circles(hexes)
    hex_lookup = hexes.index_by { |hex| [hex.column, hex.row] }

    hexes.filter { |hex| hex.terrain_type == "forest" }.flat_map do |hex|
      FOREST_BRIDGE_DIRECTIONS.flat_map do |direction|
        neighbor = neighboring_hex(hex, direction, hex_lookup)
        next [] unless neighbor&.terrain_type == "forest"
        next [] if river_between?(hex, direction, neighbor)

        build_forest_bridge_circles(hex, direction, neighbor)
      end
    end
  end

  private

  def build_forest_bridge_circles(hex, direction, neighbor)
    scale = Map::HexGridBuilder::HEX_HEIGHT / BASE_HEX_HEIGHT
    start_point, end_point = EDGE_POINTS.fetch(direction)
    global_start = [hex.svg_x + (start_point[0] * scale), hex.svg_y + (start_point[1] * scale)]
    global_end = [hex.svg_x + (end_point[0] * scale), hex.svg_y + (end_point[1] * scale)]
    midpoint = [((global_start[0] + global_end[0]) / 2.0), ((global_start[1] + global_end[1]) / 2.0)]
    normal_x, normal_y = normalized_perpendicular(global_start, global_end)
    tangent_x, tangent_y = normalized_tangent(global_start, global_end)
    seed = [hex.hex_number, neighbor.hex_number].sort.join("-").each_byte.sum
    cluster_length = Map::HexGridBuilder::HEX_WIDTH * 0.16
    cluster_depth = Map::HexGridBuilder::HEX_HEIGHT * 0.14
    canopy_layout = [
      { along: -1.9, across: -1.75, radius: 6.8, color: 0 },
      { along: -1.35, across: -0.95, radius: 6.2, color: 1 },
      { along: -0.8, across: -1.35, radius: 7.0, color: 0 },
      { along: -0.2, across: -0.55, radius: 6.0, color: 2 },
      { along: 0.35, across: 0.6, radius: 6.1, color: 2 },
      { along: 0.9, across: 1.35, radius: 7.1, color: 1 },
      { along: 1.45, across: 0.95, radius: 6.3, color: 0 },
      { along: 2.0, across: 1.75, radius: 6.9, color: 1 },
      { along: -1.1, across: 0.2, radius: 5.7, color: 2 },
      { along: 1.1, across: -0.2, radius: 5.8, color: 2 }
    ]

    canopy_layout.map.with_index do |node, index|
      along_offset = node[:along] * cluster_length
      across_offset = node[:across] * cluster_depth
      radius = node[:radius] + (((seed + index) % 3) - 1) * 0.5
      center_x = midpoint[0] + (tangent_x * along_offset) + (normal_x * across_offset)
      center_y = midpoint[1] + (tangent_y * along_offset) + (normal_y * across_offset)

      {
        cx: center_x.round(2),
        cy: center_y.round(2),
        r: radius.round(2),
        fill: FOREST_BRIDGE_COLORS[(node[:color] + seed + index) % FOREST_BRIDGE_COLORS.length],
        opacity: (0.94 + (((seed + index) % 2) * 0.03)).round(2)
      }
    end
  end

  def neighboring_hex(hex, direction, hex_lookup)
    column = hex.column
    row = hex.row

    neighbor_column, neighbor_row =
      case direction.to_s
      when "north"
        [column, row - 1]
      when "south"
        [column, row + 1]
      when "northeast"
        column.odd? ? [column + 1, row - 1] : [column + 1, row]
      when "southeast"
        column.odd? ? [column + 1, row] : [column + 1, row + 1]
      when "southwest"
        column.odd? ? [column - 1, row] : [column - 1, row + 1]
      when "northwest"
        column.odd? ? [column - 1, row - 1] : [column - 1, row]
      end

    return unless neighbor_column && neighbor_row

    hex_lookup[[neighbor_column, neighbor_row]]
  end

  def river_between?(hex, direction, neighbor)
    hex.hexside_features.any? { |feature| feature.feature_type == "river" && feature.direction == direction.to_s } ||
      neighbor.hexside_features.any? do |feature|
        feature.feature_type == "river" && feature.direction == OPPOSITE_DIRECTIONS.fetch(direction.to_s)
      end
  end

  def normalized_perpendicular(start_point, end_point)
    dx = end_point[0] - start_point[0]
    dy = end_point[1] - start_point[1]
    length = Math.sqrt((dx**2) + (dy**2))
    return [0.0, 0.0] if length.zero?

    [(-dy / length), (dx / length)]
  end

  def normalized_tangent(start_point, end_point)
    dx = end_point[0] - start_point[0]
    dy = end_point[1] - start_point[1]
    length = Math.sqrt((dx**2) + (dy**2))
    return [0.0, 0.0] if length.zero?

    [dx / length, dy / length]
  end

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

    if %i[road railroad].include?(route_style.to_sym) && !opposite_directions?(directions)
      start_point, end_point = apply_line_offset(midpoints[0], midpoints[1], lateral_offset)
      control_point = bend_control_point(directions, lateral_offset:, route_style:)
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

  def through_route_ties(directions, lateral_offset:, route_style: :generic)
    midpoints = directions.filter_map { |direction| route_midpoint(direction) }
    return "" unless midpoints.length == 2

    if route_style.to_sym == :railroad && !opposite_directions?(directions)
      start_point, end_point = apply_line_offset(midpoints[0], midpoints[1], lateral_offset)
      control_point = bend_control_point(directions, lateral_offset:, route_style:)
      return curved_tie_segments(start_point, control_point, end_point).join(" ")
    end

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

  def bend_control_point(directions, lateral_offset:, route_style: :generic)
    center = [32.0, 27.71]
    shifts = Array(directions).filter_map do |direction|
      midpoint = route_midpoint(direction)
      next unless midpoint

      perpendicular_offset(midpoint, center, lateral_offset)
    end

    return center if shifts.empty?

    avg_x = shifts.sum { |shift| shift[0] } / shifts.length.to_f
    avg_y = shifts.sum { |shift| shift[1] } / shifts.length.to_f
    style_bias = route_style.to_sym == :railroad ? 1.12 : 1.0
    [(center[0] + (avg_x * style_bias)).round(2), (center[1] + (avg_y * style_bias)).round(2)]
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

  def curved_tie_segments(start_point, control_point, end_point)
    points = sample_quadratic_curve(start_point, control_point, end_point, segments: 24)
    return [] if points.length < 2

    tie_spacing = 8.0
    tie_length = 7.0
    start_offset = 7.0
    traversed = 0.0
    target = start_offset
    segments = []

    points.each_cons(2) do |first_point, second_point|
      dx = second_point[0] - first_point[0]
      dy = second_point[1] - first_point[1]
      segment_length = Math.sqrt((dx**2) + (dy**2))
      next if segment_length.zero?

      while traversed + segment_length >= target
        ratio = (target - traversed) / segment_length
        anchor_x = first_point[0] + (dx * ratio)
        anchor_y = first_point[1] + (dy * ratio)
        unit_x = dx / segment_length
        unit_y = dy / segment_length
        normal_x = -unit_y
        normal_y = unit_x
        half_tie = tie_length / 2.0
        x1 = anchor_x - (normal_x * half_tie)
        y1 = anchor_y - (normal_y * half_tie)
        x2 = anchor_x + (normal_x * half_tie)
        y2 = anchor_y + (normal_y * half_tie)
        segments << format("M %.2f %.2f L %.2f %.2f", x1, y1, x2, y2)
        target += tie_spacing
      end

      traversed += segment_length
    end

    segments
  end

  def sample_quadratic_curve(start_point, control_point, end_point, segments:)
    (0..segments).map do |index|
      t = index / segments.to_f
      one_minus_t = 1.0 - t
      x = (one_minus_t**2 * start_point[0]) + (2 * one_minus_t * t * control_point[0]) + (t**2 * end_point[0])
      y = (one_minus_t**2 * start_point[1]) + (2 * one_minus_t * t * control_point[1]) + (t**2 * end_point[1])
      [x, y]
    end
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
    extended_points = [points.first] + points + [points.last]

    points.each_with_index do |point, index|
      next if index.zero?

      previous_control = flow_control_points(
        extended_points[index - 1],
        extended_points[index],
        extended_points[index + 1],
        extended_points[index + 2]
      )

      path << format(
        "C %.2f %.2f %.2f %.2f %.2f %.2f",
        previous_control[0][0], previous_control[0][1],
        previous_control[1][0], previous_control[1][1],
        point[0], point[1]
      )
    end
    path.join(" ")
  end

  def flow_control_points(previous_point, current_point, next_point, following_point)
    smoothing = 0.18

    first_control = [
      current_point[0] + ((next_point[0] - previous_point[0]) * smoothing),
      current_point[1] + ((next_point[1] - previous_point[1]) * smoothing)
    ]

    second_control = [
      next_point[0] - ((following_point[0] - current_point[0]) * smoothing),
      next_point[1] - ((following_point[1] - current_point[1]) * smoothing)
    ]

    wobble_horizontal_controls!(previous_point, current_point, next_point, following_point, first_control, second_control)

    first_control.map! { |value| value.round(2) }
    second_control.map! { |value| value.round(2) }

    [first_control, second_control]
  end

  def wobble_horizontal_controls!(previous_point, current_point, next_point, following_point, first_control, second_control)
    incoming_dx = current_point[0] - previous_point[0]
    incoming_dy = current_point[1] - previous_point[1]
    outgoing_dx = next_point[0] - current_point[0]
    outgoing_dy = next_point[1] - current_point[1]
    following_dx = following_point[0] - next_point[0]
    following_dy = following_point[1] - next_point[1]

    incoming_horizontal = incoming_dx.abs > 18.0 && incoming_dy.abs < 4.0
    outgoing_horizontal = outgoing_dx.abs > 18.0 && outgoing_dy.abs < 4.0
    following_horizontal = following_dx.abs > 18.0 && following_dy.abs < 4.0
    return unless incoming_horizontal || outgoing_horizontal || following_horizontal

    wobble_seed = (
      previous_point[0].round +
      current_point[0].round +
      next_point[0].round +
      following_point[0].round
    )
    wobble = 4.5 + (wobble_seed % 3)
    direction = wobble_seed.even? ? 1.0 : -1.0

    first_control[1] += wobble * direction if incoming_horizontal || outgoing_horizontal
    second_control[1] -= wobble * direction if outgoing_horizontal || following_horizontal
  end

  def point_key(point)
    format("%.2f,%.2f", point[0], point[1])
  end

  def point_from_key(key)
    x, y = key.split(",").map(&:to_f)
    [x, y]
  end
end
