class User < ActiveRecord::Base
  has_many :walks
  has_many :marks, through: :walks
  has_many :dogs, foreign_key: "owner_id"
  validates :email, uniqueness: true

  has_secure_password
end
