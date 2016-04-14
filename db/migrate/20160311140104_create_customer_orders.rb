class CreateCustomerOrders < ActiveRecord::Migration
  def change
    create_table :customer_orders do |t|

      t.string :customer_name
      t.boolean :isParcel, :default => false
      t.float :paid_amount, :default => 0
      t.float :discount_amount, :default => 0
      t.float :received_amount, :default => 0
      t.float :changed_amount, :default => 0

      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
