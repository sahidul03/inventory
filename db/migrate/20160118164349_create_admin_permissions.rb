class CreateAdminPermissions < ActiveRecord::Migration
  def change
    create_table :admin_permissions do |t|

      t.boolean :super_admin, default: false
      t.boolean :admin_creation, default: false

      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
