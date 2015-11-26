class CreateWeitingLists < ActiveRecord::Migration
  def change
    create_table :weiting_lists do |t|
      t.integer :user_id
      t.integer :modality_filiation_id
      t.integer :position

      t.timestamps null: false
    end
  end
end
