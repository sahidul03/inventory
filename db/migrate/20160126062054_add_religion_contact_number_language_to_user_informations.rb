class AddReligionContactNumberLanguageToUserInformations < ActiveRecord::Migration
  def change
    add_column :user_informations, :contact_number, :string
    add_column :user_informations, :religion, :string
    add_column :user_informations, :language, :string
    add_column :user_informations, :designation, :string
  end
end
