class Unit < ApplicationRecord
  SIDES = %w[german soviet].freeze
  UNIT_TYPES = %w[infantry armor artillery hq cavalry].freeze

  belongs_to :hex

  validates :name, presence: true
  validates :side, presence: true, inclusion: { in: SIDES }
  validates :unit_type, presence: true, inclusion: { in: UNIT_TYPES }
  validates :attack_strength, :defense_strength, :movement_allowance, presence: true,
    numericality: { only_integer: true, greater_than: 0 }

  scope :deployed, -> { order(:side, :unit_type, :name) }

  def side_label
    side.titleize
  end

  def unit_type_label
    unit_type.titleize
  end
end
