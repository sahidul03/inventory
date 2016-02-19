class FoodCategory < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :discount, :numericality => true
  validates_numericality_of :discount, :greater_than_or_equal_to => 0
  mount_uploader :photo, FoodCategoryPhotoUploader

  belongs_to :user
  has_many :food_sub_categories
end
