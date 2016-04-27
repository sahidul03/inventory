class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :admin_permission
  has_one :user_information
  has_many :food_categories
  has_many :food_sub_categories
  has_many :duplicate_orders
  has_many :customer_orders

  has_many :product_colors
  has_many :product_types
  has_many :buyers
  has_many :parties
  has_many :bank_accounts
  has_many :bank_balance_entries
  has_many :bank_balance_outs
  has_many :party_payments

end
