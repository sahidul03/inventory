class CashBalanceEntry < ActiveRecord::Base


  # 0 for original cash balance entry
  # 1 for original buyer payment

  validates :amount, :from_where, :user_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1

  belongs_to :user
end
