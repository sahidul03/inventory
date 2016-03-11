class ItemsController < ApplicationController

  def index
    @categories = FoodCategory.where(:isActive => true)
    @foods = FoodSubCategory.where(:isActive => true)
  end

  def show
    @category = FoodCategory.find(params[:id])
    @foods = @category.food_sub_categories
  end

  def add_to_card
    @duplicate_order = DuplicateOrder.find_by food_sub_category_id: params[:id], user_id: current_user.id rescue nil
    @isNewItem = 'false'
    if @duplicate_order
      @duplicate_order.update(:quantity => @duplicate_order.quantity+1)
    else
      @duplicate_order = current_user.duplicate_orders.create(:food_sub_category_id => params[:id], :quantity => 1)
      @isNewItem = 'true'
    end

    # common function call
    common_order_items_info
  end

  def remove_from_card
    @duplicate_order = DuplicateOrder.find_by food_sub_category_id: params[:id], user_id: current_user.id
    @duplicate_order.destroy

    # common function call
    common_order_items_info
  end

  def quantity_decrease
    @duplicate_order = DuplicateOrder.find_by food_sub_category_id: params[:id], user_id: current_user.id
    @isDecreasedFlag = 'false'
    if @duplicate_order.quantity > 1
      @duplicate_order.update(:quantity => @duplicate_order.quantity-1)
      @isDecreasedFlag = 'true'

      # common function call
      common_order_items_info
    end
  end

  def order_place

  end

  def common_order_items_info
    items = current_user.duplicate_orders
    @number_of_items = items.count
    @total_price_of_selected_items = 0
    items.each do |item|
      @total_price_of_selected_items = @total_price_of_selected_items + item.quantity*(item.food_sub_category.price - item.food_sub_category.discount_tk)
    end
  end


end
