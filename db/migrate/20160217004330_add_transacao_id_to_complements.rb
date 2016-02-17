class AddTransacaoIdToComplements < ActiveRecord::Migration
  def change
    add_column :complements, :transacao_id, :int
  end
end
