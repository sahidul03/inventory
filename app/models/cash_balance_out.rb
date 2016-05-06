class CashBalanceOut < ActiveRecord::Base

  validates :amount, :to_whom, :user_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1

  belongs_to :user

end
