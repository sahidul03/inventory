class FoodSubCategory < ActiveRecord::Base
  validates :name, :food_category_id, :price, presence: true
  validates :discount_tk, :price, :numericality => true
  mount_uploader :photo, FoodCategoryPhotoUploader
  belongs_to :user
  belongs_to :food_category
end
