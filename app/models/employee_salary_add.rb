class EmployeeSalaryAdd < ActiveRecord::Base
  validates :amount, :user_id, :employee_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1

  belongs_to :employee
  belongs_to :user

end
