class CreateOrderedItems < ActiveRecord::Migration
  def change
    create_table :ordered_items do |t|

      t.float :price, :default => 0
      t.integer :quantity, :default => 0

      t.references :food_sub_category, index: true
      t.references :order, index: true

      t.timestamps null: false
    end
  end
end
