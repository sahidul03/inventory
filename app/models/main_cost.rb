class MainCost < ActiveRecord::Base
  validates :amount, :expense_category_id, :expense_id, :user_id, presence: true
  validates_numericality_of :amount, :greater_than_or_equal_to => 1
  validate :bank_account_validation

  belongs_to :expense_category
  belongs_to :expense
  belongs_to :user
  belongs_to :bank_account

  def bank_account_validation
    # raise bank_account_id.inspect
    if bank_account_id.nil? || bank_account_id == ''
      self.bank_account_id = 0
    end
  end
end
