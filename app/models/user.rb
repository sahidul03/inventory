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
end
