class CreateEmployeeLeaves < ActiveRecord::Migration
  def change
    create_table :employee_leaves do |t|

      t.date :start_date
      t.date :end_date
      t.text :remarks


      t.references :user, index: true
      t.references :employee, index: true

      t.timestamps null: false
    end
  end
end
