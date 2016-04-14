class FoodSubCategory < ActiveRecord::Base
  validates :name, :food_category_id, :price, presence: true
  # validates :discount_tk, :price, :numericality => true
  validates_numericality_of :discount_tk, :price, :greater_than_or_equal_to => 0
  validate :discount_cannot_be_greater_than_price
  mount_uploader :photo, FoodCategoryPhotoUploader

  belongs_to :user
  belongs_to :food_category
  has_many :duplicate_orders
  has_many :ordered_items


  def discount_cannot_be_greater_than_price
    if discount_tk > price
      errors.add("Discount", "can't be greater than price.")
    end
  end


end
