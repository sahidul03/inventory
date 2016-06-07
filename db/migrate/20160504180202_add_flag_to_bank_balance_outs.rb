class AddFlagToBankBalanceOuts < ActiveRecord::Migration
  def change
    add_column :bank_balance_outs, :flag, :integer, default: 0
  end
end
