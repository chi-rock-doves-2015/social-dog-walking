class Dog < ActiveRecord::Base
  include StatsHelper

  has_attached_file :avatar,
  :styles => { :thumb => '60x60#', :medium => '200x200#', :large => '300x300#' }, :default_style => :large,
  :default_url => '/images/:attachment/dog-avatar.png'

  
  belongs_to  :owner, class_name: "User"
  has_many    :walked_dogs
  has_many    :walks, through: :walked_dogs
  has_many    :marks, through: :walks

  validates :name, presence: true
  validates :owner, presence: true
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 10.megabytes



  def exercised?
    #based on how recent the last walk was and how long the walk was
    #add method to caluclate the length of the last walk.
    if self.walks.last.created_at.to_i < Time.now.to_i - 86400
      return false
    else
      return true
    end
  end

end
