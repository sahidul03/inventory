class ProductExport < ActiveRecord::Base

  validates :quantity, :rate, :buyer_id, :product_type_id, :product_color_id, :export_date, :user_id, presence: true
  validates_numericality_of :quantity, :greater_than_or_equal_to => 1
  validates_numericality_of :rate, :greater_than => 0

  belongs_to :product_color
  belongs_to :product_type
  belongs_to :user
  belongs_to :buyer


  after_initialize :init
  after_save :save_total_price

  def init
    self.CNF_bill  ||= 0.0
    self.labour_cost  ||= 0.0
    self.transport_cost  ||= 0.0
    self.shipping_bill  ||= 0.0
    self.bag  ||= 0
  end


  private
  def save_total_price
    rate = self.rate
    quantity = self.quantity
    total_price = (rate*quantity)
    total_cost = self.transport_cost + self.CNF_bill + self.labour_cost + self.shipping_bill
    self.update_column(:total_price, total_price)
    self.update_column(:total_cost, total_cost)
  end

end
