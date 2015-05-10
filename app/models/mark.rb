class Mark < ActiveRecord::Base
  belongs_to :walk
  has_many :w

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

end
