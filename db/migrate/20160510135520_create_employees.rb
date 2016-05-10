class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|

      t.string :name
      t.text :address
      t.string :gender
      t.date :date_of_birth
      t.date :joining_date
      t.date :leaving_date
      t.string :nationality
      t.text :qualification
      t.string :designation
      t.float :salary, default: 0
      t.string :profile_photo
      t.boolean :isActive, default: true
      t.string :contact_number
      t.string :email
      t.string :skype_name
      t.text :work_experience
      t.string :national_id_number

      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
