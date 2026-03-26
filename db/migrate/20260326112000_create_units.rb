class CreateUnits < ActiveRecord::Migration[8.1]
  def change
    create_table :units do |t|
      t.string :name, null: false
      t.string :side, null: false
      t.string :unit_type, null: false
      t.integer :attack_strength, null: false
      t.integer :defense_strength, null: false
      t.integer :movement_allowance, null: false
      t.references :hex, null: false, foreign_key: true

      t.timestamps
    end

    add_index :units, :side
    add_index :units, :unit_type
  end
end
