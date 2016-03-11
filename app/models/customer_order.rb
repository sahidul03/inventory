class CustomerOrder < ActiveRecord::Base
  validates :paid, :received, :changed, presence: true
  validates_numericality_of :paid, :received, :greater_than_or_equal_to => 0

  belongs_to :user
  has_many :ordered_items
end
