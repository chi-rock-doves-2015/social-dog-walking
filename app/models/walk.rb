class Walk < ActiveRecord::Base
  belongs_to :user
  has_many   :marks
  has_many   :walked_dogs
  has_many   :users, through: :walked_dogs

  def duration
    updated_at - created_at
  end


  # def self.ordered_json
  #   order("created_at").to_json(methods: :mark_ids)
  # end

  # def mark_ids
  #   self.marks.pluck(:id)
  # end

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

  def distance_traveled
    distance = 0 
    if self.marks.count > 0
      self.marks.each do |mark|
        distance += mark.distance_from_last_mark
      end
    end
    distance
  end

  def distance(mark1, mark2)
    Geocoder::Calculations.distance_between([mark1.latitude,mark1.longitude], [mark2.laltitude,mark2.longitude])
  end
end
