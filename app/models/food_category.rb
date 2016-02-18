class FoodCategory < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :discount, :numericality => true

  mount_uploader :photo, FoodCategoryPhotoUploader
end
