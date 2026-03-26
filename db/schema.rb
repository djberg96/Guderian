# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_03_26_114500) do
  create_table "hexes", force: :cascade do |t|
    t.integer "column", null: false
    t.datetime "created_at", null: false
    t.string "hex_number", null: false
    t.text "notes", default: "", null: false
    t.text "railroad_exits", default: "[]", null: false
    t.text "road_exits", default: "[]", null: false
    t.integer "row", null: false
    t.float "svg_x", null: false
    t.float "svg_y", null: false
    t.string "terrain_type", default: "clear", null: false
    t.datetime "updated_at", null: false
    t.index ["hex_number"], name: "index_hexes_on_hex_number", unique: true
    t.index ["row", "column"], name: "index_hexes_on_row_and_column", unique: true
  end

  create_table "hexside_features", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "direction", null: false
    t.string "feature_type", null: false
    t.integer "hex_id", null: false
    t.datetime "updated_at", null: false
    t.index ["hex_id", "direction", "feature_type"], name: "idx_on_hex_id_direction_feature_type_7df13aa93c", unique: true
    t.index ["hex_id"], name: "index_hexside_features_on_hex_id"
  end

  create_table "units", force: :cascade do |t|
    t.integer "attack_strength", null: false
    t.datetime "created_at", null: false
    t.integer "defense_strength", null: false
    t.integer "hex_id", null: false
    t.integer "movement_allowance", null: false
    t.string "name", null: false
    t.string "side", null: false
    t.string "unit_type", null: false
    t.datetime "updated_at", null: false
    t.index ["hex_id"], name: "index_units_on_hex_id"
    t.index ["side"], name: "index_units_on_side"
    t.index ["unit_type"], name: "index_units_on_unit_type"
  end

  add_foreign_key "hexside_features", "hexes"
  add_foreign_key "units", "hexes"
end
