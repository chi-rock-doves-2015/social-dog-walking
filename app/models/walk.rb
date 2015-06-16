class Walk < ActiveRecord::Base
  belongs_to :user
  has_many   :marks
  has_many   :walked_dogs
  has_many   :dogs, through: :walked_dogs

  validates :user, presence: true

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

  def distance_traveled
    marks = self.marks
    distance = 0
    return distance if marks.count < 1
    marks.each_with_index do |mark, index|      
      previous_mark = marks[index - 1]      
      distance += Geocoder::Calculations.distance_between([previous_mark.latitude, previous_mark.longitude],[mark.latitude, mark.longitude])
    end
    distance.round(2)
  end

  def mark_coords
    first_mark = self.marks.first
    markcoords = ""
    self.marks.each do |mark|
      markcoords << "#{mark.longitude} #{mark.latitude}, "
    end
    markcoords << "#{first_mark.longitude} #{first_mark.latitude}"
    return markcoords
  end

  def area
    if self.marks.count > 2
      st_area = ActiveRecord::Base.connection.execute("select ST_Area(ST_Transform(ST_SetSRID(ST_GeomFromText('POLYGON((" +
        mark_coords + "))'), 4326), 900913));").map {|area| area["st_area"]}
      st_area[0].to_f.round(2)
    else
      0
    end
  end


# !!! STUFF I THINK WE CAN DELETE

  # def self.ordered_json
  #   order("created_at").to_json(methods: :mark_ids)
  # end

  # def mark_ids
  #   self.marks.pluck(:id)
  # end


end
