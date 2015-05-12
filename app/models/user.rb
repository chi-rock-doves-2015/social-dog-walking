class User < ActiveRecord::Base

  has_attached_file :avatar,
  :styles => { :small => '60x60#', :large => '300x300#' }, :default_style => :large,
  :default_url => '/images/:attachment/missing_:style.png',
  :path => "users/:id/avatar/:style.:extension"#,
  # :storage => :file,
  # :bucket => "scoutdoves",
  # :s3_credentials => {
  #   :access_key_id => "AKIAIR7ATUOM3FV5GDDQ",
  #   :secret_access_key => "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"
  # }


  validates :email, uniqueness: true, presence: true
  validates :username, presence: true
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 10.megabytes

  has_many :walks
  has_many :marks, through: :walks
  has_many :dogs, foreign_key: "owner_id"

  has_secure_password

  def recent_walks
    # return recent walks by some relevant data.
    # maybe this should actually be on the Walk model?
  end

  def walking_now?
    #returns whether the user is currently on recent walk- for showing a conditional back to walk button
  end


end
