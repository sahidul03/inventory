class CustomerOrdersController < ApplicationController

  def new
    @customer_order = CustomerOrder.new
  end

  def create
    @customer_order = CustomerOrder.new(params_customer_order)
    if @customer_order[:discount_amount] == nil || @customer_order[:discount_amount] == ''
      @customer_order[:discount_amount] = 0
    end
    if @customer_order[:received_amount] == nil || @customer_order[:received_amount] == ''
      @customer_order[:received_amount] = 0
    end


    items = current_user.duplicate_orders
    total_price_of_selected_items = 0
    if items.any?
      items.each do |item|
        total_price_of_selected_items = total_price_of_selected_items + item.quantity*(item.food_sub_category.price - item.food_sub_category.discount_tk)
      end
      if @customer_order.save
        paid_amount = total_price_of_selected_items - @customer_order[:discount_amount]
        changed_amount = @customer_order[:received_amount] - paid_amount
        if @customer_order.update(:paid_amount => paid_amount, :changed_amount => changed_amount)
          items.each do |item|
            price = item.quantity*(item.food_sub_category.price - item.food_sub_category.discount_tk)
            OrderedItem.create(:food_sub_category_id => item.food_sub_category_id, :price => price, :quantity => item.quantity, :customer_order_id => @customer_order.id )
            item.destroy
          end
        end
        flash[:notice] = 'Success.'
        redirect_to new_customer_order_path
      else
        render 'new'
      end
    else
      flash[:error] = 'Please select items first.'
      redirect_to items_path
    end

  end



  protected

  def params_customer_order
    params.require(:customer_order).permit(:customer_name, :isParcel, :discount_amount, :received_amount, :paid_amount, :changed_amount).merge(:user_id => current_user.id)
  end

end
