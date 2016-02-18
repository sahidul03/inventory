class FoodCategoriesController < ApplicationController

  def index
    @food_categories = FoodCategory.all
  end

  def show
    @food_category = FoodCategory.find(params[:id])
  end

  def create
    @food_category = FoodCategory.new(params_food_category)
    if @food_category.save
      flash[:notice] = "Food Category created successfully."
      redirect_to food_categories_path
    else
      render 'new'
    end
  end

  def edit
    @food_category = FoodCategory.find(params[:id])
  end

  def update
    @food_category = FoodCategory.find(params[:id])
    if @food_category.update(params_food_category)
      flash[:notice] = "Food Category updated successfully."
      redirect_to food_categories_path
    else
      render 'edit'
    end
  end

  def new
    @food_category = FoodCategory.new
  end

  protected

  def params_food_category
    params.require(:food_category).permit(:name, :isActive, :description, :discount, :photo)
  end

end
