class CreateBankBalanceOuts < ActiveRecord::Migration
  def change
    create_table :bank_balance_outs do |t|

      t.float :amount, default: true
      t.string :to_whom
      t.string :cheque_number
      t.text :remarks

      t.references :user, index: true
      t.references :bank_account, index: true


      t.timestamps null: false
    end
  end
end
