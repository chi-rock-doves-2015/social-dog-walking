class User < ActiveRecord::Base

  has_attached_file :avatar,
  :styles => { :small => '60x60#', :large => '300x300#', :medium => '200x200#' }, :default_style => :large,
  :storage => :s3,
  :default_url => '/images/:attachment/missing_:style.png',
  :path => "users/:id/avatar/:style.:extension",
  :bucket => "scoutdoves",
  :s3_credentials => {
    :access_key_id => "AKIAIR7ATUOM3FV5GDDQ",
    :secret_access_key => "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"
  }


  validates :email, uniqueness: true, presence: true 
  validates :username, presence: true
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :walks
  has_many :marks, through: :walks
  has_many :dogs, foreign_key: "owner_id"

  has_secure_password

  def recent_walks
    self.walks.order(:created_at).limit(5)
  end

  # def walking_now?
  #   #returns whether the user is currently on recent walk- for showing a conditional back to walk button
  # end



end
