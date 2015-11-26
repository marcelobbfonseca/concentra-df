class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.integer :user_id
      t.integer :modality_filiation_id

      t.timestamps null: false
    end
  end
end
