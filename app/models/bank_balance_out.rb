class BankBalanceOut < ActiveRecord::Base

  # 0 for original bank balance out
  # 1 for original party payment
  # 2 for original main cost
  # 3 for original employee payment

  validates :amount, :bank_account_id, :to_whom, :user_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1

  belongs_to :bank_account
  belongs_to :user
end
