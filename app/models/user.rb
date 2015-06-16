class User < ActiveRecord::Base
  include StatsHelper
  include Geoqueries

  has_attached_file :avatar,
  :styles => { :thumb => '60x60#', :medium => '200x200#', :large => '300x300#' }, :default_style => :large,
  :default_url => "missing_avatar.png"

  validates :email, uniqueness: true, presence: true
  validates :username, presence: true
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 10.megabytes

  has_many :walks
  has_many :marks, through: :walks
  has_many :dogs, foreign_key: "owner_id"

  has_secure_password

  def neighbors
    @neighbors ||= LocalArea.new(self)

  end


end
