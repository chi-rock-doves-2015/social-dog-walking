module StatsHelper
  def recent_walks
    self.walks.order(:created_at).limit(5)
  end

  def distance_traveled
     distance = 0
     self.walks.each do |walk|
       distance += walk.distance_traveled
     end
     distance.round(1)
  end


  def distance_score
    (distance_traveled * 250).to_i
  end

  # def area_score
  #   (area * 250).to_i
  # end

  # def combined_score

  # end


  def area
    area = 0
    self.walks.each do |walk|
      area += walk.area.to_f
    end
    area
  end

end
