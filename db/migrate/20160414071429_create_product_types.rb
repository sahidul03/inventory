class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|


      t.string :name
      t.boolean :isActive, default: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
