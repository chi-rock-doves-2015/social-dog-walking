class Walk < ActiveRecord::Base
  belongs_to :user
  has_many :marks


end
