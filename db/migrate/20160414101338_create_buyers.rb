class CreateBuyers < ActiveRecord::Migration
  def change
    create_table :buyers do |t|

      t.string :name
      t.string :address
      t.string :email
      t.string :country
      t.string :fax
      t.string :account_no
      t.string :contact_number
      t.string :skype_name
      t.string :photo
      t.string :company_name
      t.float :advance, default: 0
      t.float :due, default: 0

      t.boolean :isActive, default: true
      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
