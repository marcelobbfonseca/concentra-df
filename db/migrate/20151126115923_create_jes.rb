class CreateJes < ActiveRecord::Migration
  def change
    create_table :jes do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
