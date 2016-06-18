class CompanyInformation < ActiveRecord::Base
validates :name, :short_name, :description, presence: true
mount_uploader :logo, CompanyLogoUploader


end
