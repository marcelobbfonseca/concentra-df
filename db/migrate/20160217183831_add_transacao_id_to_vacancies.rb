class AddTransacaoIdToVacancies < ActiveRecord::Migration
  def change
    add_column :vacancies, :transacao_id, :int
  end
end
