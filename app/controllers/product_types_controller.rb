class ProductTypesController < ApplicationController

  def index
    @product_types = ProductType.all
  end

  def new
    @product_type = ProductType.new
  end

  def create
    @product_type = ProductType.new(params_product_type)
    if @product_type.save
      flash[:notice] = "Product type created successfully."
      redirect_to product_types_path
    else
      render 'new'
    end
  end

  def edit
    @product_type = ProductType.find(params[:id])
  end

  def update
    @product_type = ProductType.find(params[:id])
    if @product_type.update(params_product_type_update)
      flash[:notice] = "Product type updated successfully."
      redirect_to product_types_path
    else
      render 'edit'
    end
  end


  protected
  def params_product_type
    params.require(:product_type).permit(:name, :isActive).merge(:user_id => current_user.id)
  end
  def params_product_type_update
    params.require(:product_type).permit(:name, :isActive)
  end
end
