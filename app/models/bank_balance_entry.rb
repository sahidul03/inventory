class BankBalanceEntry < ActiveRecord::Base


  # 0 for original bank balance entry
  # 1 for original buyer payment


  validates :amount, :bank_account_id, :from_where, :user_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1

  belongs_to :bank_account
  belongs_to :user
end
