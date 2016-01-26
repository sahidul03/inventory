class UserInformation < ActiveRecord::Base

  validates :user_id, presence: true
  belongs_to :user

  mount_uploader :profile_photo, UserProfilePhotoUploader
  crop_uploaded :profile_photo
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_photo

  def crop_photo
    profile_photo.recreate_versions! if crop_x.present?
  end
  def image_reload
    unless self.profile_photo.nil?
      raise self.profile_photo.cthumb.inspect
    end
  end

end
