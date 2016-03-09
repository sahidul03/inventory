class ItemsController < ApplicationController

  def index
    @categories = FoodCategory.where(:isActive => true)
    @foods = FoodSubCategory.where(:isActive => true)
  end

end
