class BuyerPayment < ActiveRecord::Base
  validates :amount, :user_id, :payment_date, :buyer_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1
  validates_numericality_of :dollar_amount, :greater_than_or_equal_to => 1
  validates_numericality_of :bank_charge, :greater_than_or_equal_to => 0
  validate :bank_account_validation

  belongs_to :bank_account
  belongs_to :buyer
  belongs_to :user

  def bank_account_validation
    # raise bank_account_id.inspect
    if bank_account_id.nil? || bank_account_id == ''
      self.bank_account_id = 0
    end
  end
end
