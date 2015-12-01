class RecreateWaitingListTable < ActiveRecord::Migration
  def up
    create_table :waiting_lists do |t|
      t.integer :user_id
      t.integer :modality_filiation_id
      t.integer :position

      t.timestamps null: false
    end
    drop_table :weiting_lists
  end

  def down
    create_table :weiting_lists do |t|
      t.integer :user_id
      t.integer :modality_filiation_id
      t.integer :position

      t.timestamps null: false
    end
    drop_table :waiting_lists
  end
end
