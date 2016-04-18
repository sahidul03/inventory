class BankBalanceOut < ActiveRecord::Base
  validates :amount, :bank_account_id, :to_whom, :user_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1

  belongs_to :bank_account
  belongs_to :user
end