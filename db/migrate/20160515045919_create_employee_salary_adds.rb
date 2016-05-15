class CreateEmployeeSalaryAdds < ActiveRecord::Migration
  def change
    create_table :employee_salary_adds do |t|

      t.float :amount, default: 0
      t.text :remarks

      t.references :user, index: true
      t.references :employee, index: true


      t.timestamps null: false
    end
  end
end
