class AddColumnToVacancy < ActiveRecord::Migration
  def change
    add_column :vacancies, :waiting_list, :boolean
  end
end
