class Party < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :user_id, presence: true
  mount_uploader :photo, CommonPhotoUploader

  belongs_to :user
  has_many :party_payments
  has_many :product_imports
end
