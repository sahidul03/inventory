class FoodSubCategoriesController < ApplicationController

  def index
    @food_sub_categories = FoodSubCategory.all
  end

  def show
    @food_sub_category = FoodSubCategory.find(params[:id])
  end

  def create
    @food_sub_category = FoodSubCategory.new(params_food_sub_category)
    if @food_sub_category.save
      flash[:notice] = "Food Sub Category created successfully."
      redirect_to food_sub_categories_path
    else
      render 'new'
    end
  end

  def edit
    @food_sub_category = FoodSubCategory.find(params[:id])
  end

  def update
    @food_sub_category = FoodSubCategory.find(params[:id])
    if @food_sub_category.update(params_food_sub_category_update)
      flash[:notice] = "Food Sub Category updated successfully."
      redirect_to food_sub_categories_path
    else
      render 'edit'
    end
  end

  def new
    @food_sub_category = FoodSubCategory.new
  end

  protected

  def params_food_sub_category
    params.require(:food_sub_category).permit(:name, :isActive, :description, :discount_tk, :photo, :price).merge(:user_id => current_user.id, :food_category_id => params[:food_category_id])
  end

  def params_food_sub_category_update
    params.require(:food_sub_category).permit(:name, :isActive, :description, :discount_tk, :photo, :price).merge(:food_category_id => params[:food_category_id])
  end


end
