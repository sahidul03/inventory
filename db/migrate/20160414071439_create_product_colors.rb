class CreateProductColors < ActiveRecord::Migration
  def change
    create_table :product_colors do |t|

      t.string :name
      t.boolean :isActive, default: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
