class Dog < ActiveRecord::Base

  has_attached_file :avatar,
  :styles => { :medium => "300x300>", :thumb => "100x100>" },
  :default_url => 'images/:attachment/missing_:style.png',
  :path => "users/:id/avatar/:style.:extension"

  belongs_to  :owner, class_name: "User"
  has_many    :walked_dogs
  has_many    :walks, through: :walked_dogs
  has_many    :marks, through: :walks

  validates :name, presence: true
  validates :owner, presence: true
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 10.megabytes
end
