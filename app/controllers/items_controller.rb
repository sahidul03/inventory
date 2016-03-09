class ItemsController < ApplicationController

  def index
    @categories = FoodCategory.where(:isActive => true)
    @foods = FoodSubCategory.where(:isActive => true)
  end

  def show
    @category = FoodCategory.find(params[:id])
    @foods = @category.food_sub_categories
  end

end
