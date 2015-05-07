class User < ActiveRecord::Base
  has_many :walks
  has_many :marks, through: :walks

  has_secure_password
end
