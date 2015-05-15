class Walk < ActiveRecord::Base
  belongs_to :user
  has_many   :marks
  has_many   :walked_dogs
  has_many   :dogs, through: :walked_dogs

  validates :user, presence: true

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

  def mark_coords
    first_mark = self.marks.first
    markcoords = ""
    self.marks.each do |mark|
      markcoords = markcoords + mark.coords.y.to_s + " " + mark.coords.x.to_s + ", "
    end
    markcoords = markcoords + first_mark.coords.y.to_s + " " + first_mark.coords.x.to_s
    return markcoords
  end

  def area
    if self.marks.count > 2
      st_area = ActiveRecord::Base.connection.execute("select ST_Area(ST_Transform(ST_SetSRID(ST_GeomFromText('POLYGON((" +
        mark_coords + "))'), 4326), 900913));").map {|area| area["st_area"]}
      st_area[0].to_f.round(1)
    else
      0
    end
  end
end
