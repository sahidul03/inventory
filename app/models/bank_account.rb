class BankAccount < ActiveRecord::Base
  validates :bank_name, :branch_name, :account_name, :account_number, :isActive, :user_id, presence: true
  validates_numericality_of :balance, :greater_than_or_equal_to => 0

  belongs_to :user

end
