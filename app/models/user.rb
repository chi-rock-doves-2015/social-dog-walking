class User < ActiveRecord::Base

  has_attached_file :avatar,
  :styles => { :thumb => '60x60#', :medium => '200x200#', :large => '300x300#' }, :default_style => :large,
  :default_url => '/images/:attachment/missing_:style.png',
  :path => "users/:id/avatar/:style.:extension"

  validates :email, uniqueness: true, presence: true
  validates :username, presence: true
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 10.megabytes

  has_many :walks
  has_many :marks, through: :walks
  has_many :dogs, foreign_key: "owner_id"

  has_secure_password

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



  def distance_score
    (distance_traveled * 250).to_i
  end



end
