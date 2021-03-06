class ProductColor < ActiveRecord::Base
  validates :name , presence: true, uniqueness: { case_sensitive: false }
  validates :user_id, presence: true

  belongs_to :user
  has_many :storage_product_adds
  has_many :storage_product_outs
  has_many :product_imports
  has_many :product_exports
end
