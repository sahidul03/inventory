class CreateBankAccounts < ActiveRecord::Migration
  def change
    create_table :bank_accounts do |t|

      t.string :bank_name
      t.string :branch_name
      t.string :account_name
      t.string :account_number
      t.string :account_type
      t.text :details

      t.float :balance, null:false, default: 0


      t.boolean :isActive, default: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
