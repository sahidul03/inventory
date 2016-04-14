class ProductColorsController < ApplicationController

  def index
    @product_colors = ProductColor.all
  end

  def new
    @product_color = ProductColor.new
  end

  def create
    @product_color = ProductColor.new(params_product_color)
    if @product_color.save
      flash[:notice] = "Product color created successfully."
      redirect_to product_colors_path
    else
      render 'new'
    end
  end

  def edit
    @product_color = ProductColor.find(params[:id])
  end

  def update
    @product_color = ProductColor.find(params[:id])
    if @product_color.update(params_product_color_update)
      flash[:notice] = "Product color updated successfully."
      redirect_to product_colors_path
    else
      render 'new'
    end
  end


  protected
  def params_product_color
    params.require(:product_color).permit(:name, :isActive).merge(:user_id => current_user.id)
  end
  def params_product_color_update
    params.require(:product_color).permit(:name, :isActive)
  end

end
