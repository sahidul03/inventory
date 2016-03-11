class OrderedItem < ActiveRecord::Base

  validates :order_id, :food_sub_category_id, :price, :quantity, presence: true

  belongs_to :customer_order
  belongs_to :food_sub_category
end
