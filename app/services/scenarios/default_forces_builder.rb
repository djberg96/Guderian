module Scenarios
  class DefaultForcesBuilder
    class << self
      def rebuild!
        Unit.transaction do
          Unit.delete_all
          Unit.insert_all!(unit_attributes, record_timestamps: true)
        end
      end

      def side_assignments
        {
          human: "german",
          ai: "soviet"
        }
      end

      private

      def unit_attributes
        default_units.map do |unit|
          {
            name: unit.fetch(:name),
            side: unit.fetch(:side),
            unit_type: unit.fetch(:unit_type),
            attack_strength: unit.fetch(:attack_strength),
            defense_strength: unit.fetch(:defense_strength),
            movement_allowance: unit.fetch(:movement_allowance),
            hex_id: Hex.find_by!(hex_number: unit.fetch(:hex_number)).id
          }
        end
      end

      def default_units
        [
          { name: "7th Panzer", side: "german", unit_type: "armor", attack_strength: 8, defense_strength: 6, movement_allowance: 8, hex_number: "0606" },
          { name: "10th Panzer", side: "german", unit_type: "armor", attack_strength: 7, defense_strength: 6, movement_allowance: 8, hex_number: "0607" },
          { name: "29th Motorized", side: "german", unit_type: "infantry", attack_strength: 6, defense_strength: 5, movement_allowance: 6, hex_number: "0706" },
          { name: "17th Panzer", side: "german", unit_type: "armor", attack_strength: 7, defense_strength: 5, movement_allowance: 8, hex_number: "0808" },
          { name: "13th Army", side: "soviet", unit_type: "infantry", attack_strength: 4, defense_strength: 5, movement_allowance: 4, hex_number: "1717" },
          { name: "20th Army", side: "soviet", unit_type: "infantry", attack_strength: 4, defense_strength: 4, movement_allowance: 4, hex_number: "1818" },
          { name: "5th Mechanized", side: "soviet", unit_type: "armor", attack_strength: 5, defense_strength: 4, movement_allowance: 6, hex_number: "1917" },
          { name: "Smolensk HQ", side: "soviet", unit_type: "hq", attack_strength: 2, defense_strength: 3, movement_allowance: 4, hex_number: "2020" }
        ]
      end
    end
  end
end
