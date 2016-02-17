class RemoveTransacaoIdToComplements < ActiveRecord::Migration
  def change
    remove_column :complements, :transacao_id, :int
  end
end
