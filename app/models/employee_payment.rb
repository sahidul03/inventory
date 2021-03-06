class EmployeePayment < ActiveRecord::Base
  validates :amount, :user_id, :payment_date, :employee_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1
  validate :bank_account_validation

  belongs_to :bank_account
  belongs_to :employee
  belongs_to :user

  def bank_account_validation
    # raise bank_account_id.inspect
    if bank_account_id.nil? || bank_account_id == ''
      self.bank_account_id = 0
    end
  end
end
