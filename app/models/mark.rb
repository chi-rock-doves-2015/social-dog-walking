class Mark < ActiveRecord::Base
  belongs_to :walk

  def create
    Mark.create(latitude: 5, longitude: 5)
    #Need geo-location stuff here!!!!!!!!
  end
end
