class Mark < ActiveRecord::Base
  belongs_to :walk

  def create
    Mark.create(latitude: 5, longitude: 5)
    #Need geo-location stuff here!!!!!!!!
  end

  def self.ordered_json
    order("created_at").to_json(methods: :walk_id)
  end

  def walk_id
    self.walk.id
  end

  def distance_from_last_mark
    if self.prev
      Geocoder::Calculations.distance_between([self.prev.longitude, self.prev.latitude],[self.longitude, self.latitude])
    else
      0
    end
  end

  def next
    self.walk.marks.where("id > ?", id).first
  end

  def prev
    self.walk.marks.where("id < ?", id).last
  end

  def longitude
    self.coords.x
  end


  def latitude
    self.coords.y
  end

end

