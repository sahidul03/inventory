class Expense < ActiveRecord::Base
  validates :name , presence: true, uniqueness: { case_sensitive: false, scope: :expense_category_id}
  validates :user_id, :expense_category_id, presence: true

  belongs_to :user
  belongs_to :expense_category
  has_many :main_costs
end
