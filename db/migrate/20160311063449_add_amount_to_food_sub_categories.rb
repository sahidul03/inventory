class AddAmountToFoodSubCategories < ActiveRecord::Migration
  def change
    add_column :food_sub_categories, :amount, :string
  end
end
