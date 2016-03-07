class ItemsController < ApplicationController

  def index
    @foods = FoodSubCategory.all
  end

end
