class AddFlagToCashBalanceEntries < ActiveRecord::Migration
  def change
    add_column :cash_balance_entries, :flag, :integer, default: 0
  end
end
