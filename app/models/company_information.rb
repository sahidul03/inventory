class CompanyInformation < ActiveRecord::Base
validates :name, :short_name, :description, presence: true

end
