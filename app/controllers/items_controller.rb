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
    @duplicate_order = DuplicateOrder.find_by_food_sub_category_id(params[:id]) rescue nil
    @isNewItem = 'false'
    if @duplicate_order
      @duplicate_order.update(:quantity => @duplicate_order.quantity+1)
    else
      @duplicate_order = current_user.duplicate_orders.create(:food_sub_category_id => params[:id], :quantity => 1)
      @isNewItem = 'true'
    end

    items = DuplicateOrder.all
    @number_of_items = items.count
    @total_price_of_selected_items = 0
    items.each do |item|
      @total_price_of_selected_items = @total_price_of_selected_items + item.quantity*(item.food_sub_category.price - item.food_sub_category.discount_tk)
    end
  end

  def remove_from_card
    @duplicate_order = DuplicateOrder.find_by_food_sub_category_id(params[:id])
    @duplicate_order.destroy

    items = DuplicateOrder.all
    @number_of_items = items.count
    @total_price_of_selected_items = 0
    items.each do |item|
      @total_price_of_selected_items = @total_price_of_selected_items + item.quantity*(item.food_sub_category.price - item.food_sub_category.discount_tk)
    end
  end

  def quantity_decrease
    @duplicate_order = DuplicateOrder.find_by_food_sub_category_id(params[:id])
    @isDecreasedFlag = 'false'
    if @duplicate_order.quantity > 1
      @duplicate_order.update(:quantity => @duplicate_order.quantity-1)
      @isDecreasedFlag = 'true'

      items = DuplicateOrder.all
      @number_of_items = items.count
      @total_price_of_selected_items = 0
      items.each do |item|
        @total_price_of_selected_items = @total_price_of_selected_items + item.quantity*(item.food_sub_category.price - item.food_sub_category.discount_tk)
      end
    end
  end

end
