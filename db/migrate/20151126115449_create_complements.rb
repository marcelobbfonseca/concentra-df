class CreateComplements < ActiveRecord::Migration
  def change
    create_table :complements do |t|
      t.string :name
      t.string :cpf
      t.string :rg
      t.string :photo
      t.string :badge_name
      t.integer :user_id
      t.integer :je_id

      t.timestamps null: false
    end
  end
end
