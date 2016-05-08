class AddFlagToCashBalanceOuts < ActiveRecord::Migration
  def change
    add_column :cash_balance_outs, :flag, :integer, default: 0
  end
end
