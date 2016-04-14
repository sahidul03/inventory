class ProductType < ActiveRecord::Base
  validates :name , presence: true, uniqueness: { case_sensitive: false }
  validates :user_id, presence: true

  belongs_to :user

end
