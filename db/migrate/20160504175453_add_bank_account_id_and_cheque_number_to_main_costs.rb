class AddBankAccountIdAndChequeNumberToMainCosts < ActiveRecord::Migration
  def change
    add_column :main_costs, :bank_account_id, :integer
    add_column :main_costs, :cheque_number, :string
  end
end
