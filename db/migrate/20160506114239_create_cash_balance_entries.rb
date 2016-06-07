class CreateCashBalanceEntries < ActiveRecord::Migration
  def change
    create_table :cash_balance_entries do |t|

      t.float :amount, default: true
      t.string :from_where
      t.text :remarks

      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
