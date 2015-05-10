class User < ActiveRecord::Base

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :walks
  has_many :marks, through: :walks
  has_many :dogs, foreign_key: "owner_id"
  validates :email, uniqueness: true

  has_secure_password

  def recent_walks
    # return recent walks by some relevant data.
    # maybe this should actually be on the Walk model?
  end

  def walking_now?
    #returns whether the user is currently on recent walk- for showing a conditional back to walk button
  end


end
