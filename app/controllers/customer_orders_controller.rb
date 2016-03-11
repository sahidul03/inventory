class CustomerOrdersController < ApplicationController

  def new
    @customer_order = CustomerOrder.new
  end

end
