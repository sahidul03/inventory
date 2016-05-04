class AddFlagToBankBalanceEntries < ActiveRecord::Migration
  def change
    add_column :bank_balance_entries, :flag, :integer, default: 0
  end
end
