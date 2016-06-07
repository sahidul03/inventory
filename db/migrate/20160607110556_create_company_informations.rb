class CreateCompanyInformations < ActiveRecord::Migration
  def change
    create_table :company_informations do |t|

      t.string :name
      t.string :short_name
      t.text :description
      t.string :email
      t.string :contact_number
      t.text :address
      t.string :fax

      t.timestamps null: false
    end
  end
end
