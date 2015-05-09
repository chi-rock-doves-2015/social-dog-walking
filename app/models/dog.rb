class Dog < ActiveRecord::Base

  belongs_to  :owner, class_name: "User"
  has_many    :walked_dogs
  has_many    :walks, through: :walked_dogs
  has_many    :marks, through: :walks

  validates :name, presence: true
  validates :owner, presence: true
end
