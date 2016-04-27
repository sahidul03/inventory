class BankAccount < ActiveRecord::Base
  validates :bank_name, :branch_name, :account_name, :account_number, :user_id, presence: true
  validates_numericality_of :balance, :greater_than_or_equal_to => 0

  belongs_to :user
  has_many :bank_balance_entries
  has_many :bank_balance_outs
  has_many :party_payments

end
