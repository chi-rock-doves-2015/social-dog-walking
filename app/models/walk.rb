class Walk < ActiveRecord::Base
  belongs_to :user
  has_many :marks

  def duration
    updated_at - created_at
  end
end
