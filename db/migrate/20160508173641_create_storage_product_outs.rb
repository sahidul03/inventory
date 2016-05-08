class CreateStorageProductOuts < ActiveRecord::Migration
  def change
    create_table :storage_product_outs do |t|

      t.references :user, index: true
      t.references :product_type, index: true
      t.references :product_color, index: true

      t.float :quantity, default: 0
      t.text :remarks

      t.timestamps null: false
    end
  end
end
