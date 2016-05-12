class Employee < ActiveRecord::Base
  validates :user_id, :name, presence: true
  validates :name, :uniqueness => { case_sensitive: false }

  belongs_to :user
  has_many :employee_leaves

  mount_uploader :profile_photo, UserProfilePhotoUploader
  crop_uploaded :profile_photo
  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h
  after_update :crop_photo

  def crop_photo
    profile_photo.recreate_versions! if crop_x.present?
  end

end
