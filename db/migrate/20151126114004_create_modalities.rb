class CreateModalities < ActiveRecord::Migration
  def change
    create_table :modalities do |t|
      t.string :name
      t.integer :vacancy

      t.timestamps null: false
    end
  end
end
