class DuplicateOrder < ActiveRecord::Base
  validates :user_id, :food_sub_category_id, presence: true

  belongs_to :user
  belongs_to :food_sub_category
end
