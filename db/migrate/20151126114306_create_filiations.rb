class CreateFiliations < ActiveRecord::Migration
  def change
    create_table :filiations do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
