class CashBalanceOut < ActiveRecord::Base

  # 0 for original cash balance out
  # 1 for original party payment
  # 2 for original main cost
  # 3 for original employee payment
  # 4 for original export cost
  # 5 for original import cost


  validates :amount, :to_whom, :user_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1

  belongs_to :user

end
