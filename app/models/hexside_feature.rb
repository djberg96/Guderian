class HexsideFeature < ApplicationRecord
  FEATURE_TYPES = %w[river lake].freeze

  belongs_to :hex

  validates :direction, presence: true, inclusion: { in: Hex::EDGE_DIRECTIONS }
  validates :feature_type, presence: true, inclusion: { in: FEATURE_TYPES }
  validates :direction, uniqueness: { scope: [:hex_id, :feature_type] }

  def asset_path
    "hexsides/#{feature_type}_#{direction}.svg"
  end
end
