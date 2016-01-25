class UserInformation < ActiveRecord::Base

  validates :user_id, presence: true
  mount_uploader :profile_photo, UserProfilePhotoUploader

  belongs_to :user
end
