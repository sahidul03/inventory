class CreateCashBalanceOuts < ActiveRecord::Migration
  def change
    create_table :cash_balance_outs do |t|

      t.float :amount, default: true
      t.string :to_whom
      t.text :remarks

      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
