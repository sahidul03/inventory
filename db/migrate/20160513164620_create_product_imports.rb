class CreateProductImports < ActiveRecord::Migration
  def change
    create_table :product_imports do |t|

      t.integer :quantity, default: 0
      t.float :convince, default: 0, null: false
      t.float :rate, default: 0
      t.float :labour_cost, default: 0, null: false
      t.string :car_number
      t.date :import_date
      t.text :remarks
      t.float :total_price, default: 0

      t.references :user, index: true
      t.references :party, index: true
      t.references :product_type, index: true
      t.references :product_color, index: true

      t.timestamps null: false
    end
  end
end
