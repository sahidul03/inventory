class Buyer < ActiveRecord::Base
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :user_id, presence: true
  mount_uploader :photo, CommonPhotoUploader

  belongs_to :user
end
