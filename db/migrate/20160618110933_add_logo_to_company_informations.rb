class AddLogoToCompanyInformations < ActiveRecord::Migration
  def change
    add_column :company_informations, :logo, :string
  end
end
