class User < ActiveRecord::Base
  has_many :walks
  has_many :marks, through: :walks
  validates :email, uniqueness: true

  has_secure_password
end