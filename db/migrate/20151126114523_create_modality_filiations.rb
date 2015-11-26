class CreateModalityFiliations < ActiveRecord::Migration
  def change
    create_table :modality_filiations do |t|
      t.integer :modality_id
      t.integer :filiation_id
      t.string :name
      t.float :price

      t.timestamps null: false
    end
  end
end
