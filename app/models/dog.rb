class Dog < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "200x200#", :thumb => "50x50#", :large => "300x300#" }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  belongs_to  :owner, class_name: "User"
  has_many    :walked_dogs
  has_many    :walks, through: :walked_dogs
  has_many    :marks, through: :walks

  validates :name, presence: true
  validates :owner, presence: true
end
