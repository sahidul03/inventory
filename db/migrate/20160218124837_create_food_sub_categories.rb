class CreateFoodSubCategories < ActiveRecord::Migration
  def change
    create_table :food_sub_categories do |t|
      t.string :name
      t.boolean :isActive, default: true
      t.float :discount_tk, default: 0
      t.float :price, default: 0
      t.text :description
      t.string :photo

      t.references :user, index: true
      t.references :food_category, index: true

      t.timestamps null: false
    end
  end
end
