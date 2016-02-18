class CreateFoodCategories < ActiveRecord::Migration
  def change
    create_table :food_categories do |t|
      t.string :name
      t.boolean :isActive, default: true
      t.float :discount, default: 0
      t.text :description
      t.string :photo

      t.timestamps null: false
    end
  end
end
