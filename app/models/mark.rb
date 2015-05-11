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
    Geocoder::Calculations.distance_between([self.walk.marks.last.longitude, self.walk.marks.last.latitude],[self.longitude, self.latitude])
  end

end
