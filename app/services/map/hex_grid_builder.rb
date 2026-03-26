module Map
  class HexGridBuilder
    ROW_COUNT = 31
    HEXES_PER_ROW = 31
    HEX_SIZE = 32.0
    HEX_WIDTH = HEX_SIZE * 2.0
    HEX_HEIGHT = Math.sqrt(3) * HEX_SIZE
    HORIZONTAL_STEP = HEX_WIDTH * 0.75
    VERTICAL_STEP = HEX_HEIGHT * 0.5
    ODD_ROW_OFFSET = HORIZONTAL_STEP / 2.0
    BOARD_PADDING = 24.0

    class << self
      def rebuild!
        Hex.transaction do
          Hex.delete_all
          Hex.insert_all!(hex_attributes, record_timestamps: true)
        end
      end

      def board_metrics
        {
          width: ((HEXES_PER_ROW - 1) * HORIZONTAL_STEP) + HEX_WIDTH + ODD_ROW_OFFSET + (BOARD_PADDING * 2),
          height: ((ROW_COUNT - 1) * VERTICAL_STEP) + HEX_HEIGHT + (BOARD_PADDING * 2)
        }
      end

      private

      def hex_attributes
        (1..ROW_COUNT).flat_map do |row_number|
          (1..HEXES_PER_ROW).map do |column_number|
            {
              hex_number: format("%<row>02d%<column>02d", row: row_number, column: column_number),
              row: row_number,
              column: column_number,
              terrain_type: terrain_type_for(row_number, column_number),
              svg_x: svg_x_for(row_number, column_number),
              svg_y: svg_y_for(row_number),
              notes: "",
              road_exits: road_exits_for(row_number, column_number).to_json,
              railroad_exits: railroad_exits_for(row_number, column_number).to_json
            }
          end
        end
      end

      def svg_x_for(row_number, column_number)
        BOARD_PADDING +
          ((column_number - 1) * HORIZONTAL_STEP) +
          (row_number.even? ? ODD_ROW_OFFSET : 0.0)
      end

      def svg_y_for(row_number)
        BOARD_PADDING + ((row_number - 1) * VERTICAL_STEP)
      end

      def terrain_type_for(row_number, column_number)
        return "major_city" if [row_number, column_number] == [16, 16]
        return "minor_city" if [[12, 11], [19, 20], [23, 24]].include?([row_number, column_number])
        return "swamp" if row_number.between?(21, 24) && column_number.between?(8, 11)
        return "forest" if (row_number + column_number).modulo(7).zero?

        "clear"
      end

      def road_exits_for(row_number, column_number)
        if row_number == 16 && column_number.between?(4, 25)
          %w[north south]
        elsif column_number == 12 && row_number.between?(8, 20)
          %w[northeast southwest]
        else
          []
        end
      end

      def railroad_exits_for(row_number, column_number)
        return [] unless row_number == column_number && row_number.between?(6, 26)

        %w[northwest southeast]
      end
    end
  end
end
