class CreateUserInformations < ActiveRecord::Migration
  def change
    create_table :user_informations do |t|

      t.string :first_name
      t.string :last_name
      t.string :profile_photo
      t.string :gender
      t.text :address
      t.string :nationality
      t.date :date_of_birth

      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
