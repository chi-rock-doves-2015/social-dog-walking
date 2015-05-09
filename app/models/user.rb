class User < ActiveRecord::Base

  has_attached_file :avatar,
  :styles => { :small => '60x60#', :large => '300x300#' }, :default_style => :large,
  :storage => :s3,
  :default_url => '/images/:attachment/missing_:style.png',
  :path => "users/:id/avatar/:style.:extension",
  :bucket => "bucket name",
  :s3_credentials => {
    :access_key_id => "AKIAIR7ATUOM3FV5GDDQ",
    :secret_access_key => "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"
  }


  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :walks
  has_many :marks, through: :walks
  has_many :dogs, foreign_key: "owner_id"
  validates :email, uniqueness: true

  has_secure_password
end
