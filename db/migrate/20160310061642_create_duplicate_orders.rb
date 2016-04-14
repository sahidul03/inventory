class CreateDuplicateOrders < ActiveRecord::Migration
  def change
    create_table :duplicate_orders do |t|

      t.integer :quantity, default: 1

      t.references :user, index: true
      t.references :food_sub_category, index: true

      t.timestamps null: false
    end
  end
end
