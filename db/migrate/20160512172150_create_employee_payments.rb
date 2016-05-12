class CreateEmployeePayments < ActiveRecord::Migration
  def change
    create_table :employee_payments do |t|

      t.float :amount, default: 0
      t.string :cheque_number
      t.text :remarks
      t.date :payment_date

      t.references :user, index: true
      t.references :employee, index: true
      t.integer :bank_account_id, default: 0

      t.timestamps null: false
    end
  end
end
