class EmployeeLeave < ActiveRecord::Base
  validates :start_date, :end_date, :employee_id, presence: true
  validate :start_date_greater_than_end_date_check

  belongs_to :employee
  belongs_to :user


  def start_date_greater_than_end_date_check
    if start_date > end_date
      errors.add(:base, "Start date is greater than end date.")
    end
  end

end
