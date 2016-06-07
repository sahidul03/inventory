class CreateProductExports < ActiveRecord::Migration
  def change
    create_table :product_exports do |t|

      t.integer :quantity, default: 0
      t.integer :bag, default: 0
      t.float :CNF_bill, default: 0, null: false
      t.float :transport_cost, default: 0, null: false
      t.float :total_cost, default: 0, null: false
      t.float :shipping_bill, default: 0, null: false
      t.float :rate, default: 0
      t.float :labour_cost, default: 0, null: false
      t.string :car_number
      t.date :export_date
      t.text :remarks
      t.float :total_price, default: 0

      t.references :user, index: true
      t.references :buyer, index: true
      t.references :product_type, index: true
      t.references :product_color, index: true

      t.timestamps null: false
    end
  end
end
