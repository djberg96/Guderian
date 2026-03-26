class CreateHexes < ActiveRecord::Migration[8.1]
  def change
    create_table :hexes do |t|
      t.string :hex_number, null: false
      t.integer :row, null: false
      t.integer :column, null: false
      t.string :terrain, null: false, default: "clear"
      t.float :svg_x, null: false
      t.float :svg_y, null: false
      t.text :notes, null: false, default: ""

      t.timestamps
    end

    add_index :hexes, :hex_number, unique: true
    add_index :hexes, [:row, :column], unique: true
  end
end
