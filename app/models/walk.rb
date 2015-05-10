class Walk < ActiveRecord::Base
  belongs_to :user
  has_many   :marks
  has_many   :walked_dogs
  has_many   :users, through: :walked_dogs

  def duration
    updated_at - created_at
  end

  def complete?
    #should probably be a boolean field 'complete' defaulting to false
    #return true if self.complete
    # self.complete = true if last mark is more than 2 hours old
    # return self.complete
  end

  def fair_walk?
    # return whether the game followed our rules
    # (no impossible walks, obvious motor vehicle travel, etc)
  end


end
