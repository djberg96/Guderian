class Hex < ApplicationRecord
  TERRAIN_TYPES = %w[clear forest major_city minor_city swamp].freeze
  EDGE_DIRECTIONS = %w[north northeast southeast south southwest northwest].freeze

  has_many :units, dependent: :restrict_with_exception
  has_many :hexside_features, dependent: :destroy

  validates :hex_number, presence: true, uniqueness: true, format: { with: /\A\d{4}\z/ }
  validates :row, :column, :svg_x, :svg_y, presence: true
  validates :terrain_type, presence: true, inclusion: { in: TERRAIN_TYPES }
  validates :column, uniqueness: { scope: :row }

  def road_exits
    read_direction_list(:road_exits)
  end

  def road_exits=(directions)
    write_direction_list(:road_exits, directions)
  end

  def railroad_exits
    read_direction_list(:railroad_exits)
  end

  def railroad_exits=(directions)
    write_direction_list(:railroad_exits, directions)
  end

  scope :in_display_order, -> { order(:row, :column) }

  def label
    hex_number
  end

  def terrain_asset_paths
    return %w[terrain/clear.svg terrain/forest_bushy.svg] if terrain_type == "forest"

    ["terrain/#{terrain_type}.svg"]
  end

  private

  def read_direction_list(attribute_name)
    value = self[attribute_name]
    return [] if value.blank?

    JSON.parse(value)
  rescue JSON::ParserError
    []
  end

  def write_direction_list(attribute_name, directions)
    normalized = Array(directions).map(&:to_s).uniq
    invalid = normalized - EDGE_DIRECTIONS
    raise ArgumentError, "Unsupported directions: #{invalid.join(', ')}" if invalid.any?

    self[attribute_name] = normalized.to_json
  end
end
