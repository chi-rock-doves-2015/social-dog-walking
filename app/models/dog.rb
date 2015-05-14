class Dog < ActiveRecord::Base

  has_attached_file :avatar,
  :styles => { :thumb => '60x60#', :medium => '200x200#', :large => '300x300#' }, :default_style => :large,
  :default_url => '/images/:attachment/dog-avatar.png',
  :path => "users/:id/avatar/:style.:extension"

  belongs_to  :owner, class_name: "User"
  has_many    :walked_dogs
  has_many    :walks, through: :walked_dogs
  has_many    :marks, through: :walks

  validates :name, presence: true
  validates :owner, presence: true
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 10.megabytes


  def happy?
    #based on how recent the last walk was and how long the walk was
    #add method to caluclate the length of the last walk.
    if self.owner.walks.last.created_at.to_i < Time.now.to_i - 86400
      return false
    else
      return true
    end
  end

  def recent_walks
    self.walks.order(:created_at).limit(5)
  end

  def distance_traveled
     distance = 0
     self.walks.each do |walk|
       distance += walk.distance_traveled
     end
     distance.round(1)
  end


end
