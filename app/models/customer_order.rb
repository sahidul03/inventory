class CustomerOrder < ActiveRecord::Base
  validates :paid_amount, :received_amount, :changed_amount, presence: true
  validates_numericality_of :paid_amount, :received_amount, :greater_than_or_equal_to => 0
  validate :order_place_validation

  belongs_to :user
  has_many :ordered_items


  def order_place_validation
    curr_user = User.find(user_id)
    items = curr_user.duplicate_orders
    total_price_of_selected_items = 0
    if items.any?
      items.each do |item|
        total_price_of_selected_items = total_price_of_selected_items + item.quantity*(item.food_sub_category.price - item.food_sub_category.discount_tk)
      end
      if total_price_of_selected_items - discount_amount > received_amount
        errors.add(:base, "Received amount must be greater than or equal #{total_price_of_selected_items - discount_amount}")
      end
    else
      errors.add(:base, "Please select item first.")
    end
  end

end
