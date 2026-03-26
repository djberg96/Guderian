module Map
  class HexGridBuilder
    ROW_COUNT = 31
    COLUMN_COUNT = 59
    CSS_PIXELS_PER_INCH = 96.0
    HEX_HEIGHT = CSS_PIXELS_PER_INCH
    HEX_SIZE = HEX_HEIGHT / Math.sqrt(3)
    HEX_WIDTH = HEX_SIZE * 2.0
    HORIZONTAL_STEP = HEX_WIDTH * 0.75
    COLUMN_VERTICAL_OFFSET = HEX_HEIGHT * 0.5
    BOARD_PADDING = 24.0

    class << self
      def rebuild!
        Hex.transaction do
          HexsideFeature.delete_all if defined?(HexsideFeature)
          Unit.delete_all if defined?(Unit)
          Hex.delete_all
          Hex.insert_all!(hex_attributes, record_timestamps: true)
        end
      end

      def board_metrics
        {
          width: ((COLUMN_COUNT - 1) * HORIZONTAL_STEP) + HEX_WIDTH + (BOARD_PADDING * 2),
          height: (ROW_COUNT * HEX_HEIGHT) + COLUMN_VERTICAL_OFFSET + (BOARD_PADDING * 2)
        }
      end

      private

      def hex_attributes
        (1..COLUMN_COUNT).flat_map do |column_number|
          (1..ROW_COUNT).map do |row_number|
            {
              hex_number: format("%<column>02d%<row>02d", column: column_number, row: row_number),
              row: row_number,
              column: column_number,
              terrain_type: "clear",
              svg_x: svg_x_for(column_number),
              svg_y: svg_y_for(row_number, column_number),
              notes: "",
              road_exits: [].to_json,
              railroad_exits: [].to_json
            }
          end
        end
      end

      def svg_x_for(column_number)
        BOARD_PADDING + ((column_number - 1) * HORIZONTAL_STEP)
      end

      def svg_y_for(row_number, column_number)
        BOARD_PADDING + ((row_number - 1) * HEX_HEIGHT) + column_offset_for(column_number:)
      end

      def column_offset_for(column_number:)
        column_number.even? ? COLUMN_VERTICAL_OFFSET : 0.0
      end
    end
  end
end
