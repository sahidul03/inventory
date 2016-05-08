class StorageProductOut < ActiveRecord::Base
  validates :quantity, :product_type_id, :product_color_id, :user_id, presence: true
  validates_numericality_of :quantity, :greater_than_or_equal_to => 1

  belongs_to :product_color
  belongs_to :product_type
  belongs_to :user

end
