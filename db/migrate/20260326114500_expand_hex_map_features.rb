class ExpandHexMapFeatures < ActiveRecord::Migration[8.1]
  def change
    change_table :hexes, bulk: true do |t|
      t.rename :terrain, :terrain_type
      t.text :road_exits, null: false, default: "[]"
      t.text :railroad_exits, null: false, default: "[]"
    end

    create_table :hexside_features do |t|
      t.references :hex, null: false, foreign_key: true
      t.string :direction, null: false
      t.string :feature_type, null: false

      t.timestamps
    end

    add_index :hexside_features, [:hex_id, :direction, :feature_type], unique: true
  end
end
