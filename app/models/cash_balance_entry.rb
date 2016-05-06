class CashBalanceEntry < ActiveRecord::Base
  validates :amount, :from_where, :user_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1

  belongs_to :user
end
