class LocalArea
  attr_reader :marks, :neighbors, :dogs, :walks
  public

  def initialize(marker)

    sql = "SELECT * FROM marks WHERE ST_DWithin(coords, '#{marker.centroid}', 1000);"

    marks_object = ActiveRecord::Base.connection.execute(sql)

    @marks = marks_object.map do |mark_data|
      Mark.new(mark_data)
    end

    @neighbors = @marks.map do |mark|
      mark.walk.user
    end.uniq.compact

    @walks = @marks.map {|mark| mark.walk}.compact.uniq

    @dogs = @marks.map do |mark|
      mark.walk.dogs
    end.flatten.compact.uniq

    subtract_current_user(marker.id)

  end


  # # return "POINT (coords)" of marker based on all marks - extracting this to different module
  # def self.centroid(marker)
    
  #   coords = marker.marks.map {|mark| mark.coords.to_s.sub("POINT (", '').sub(')', '')}
  #   coords = coords.join(", ")


  #   sql = "SELECT ST_AsText(ST_Centroid('MULTIPOINT ( " + coords +" )'));"
  #   puts sql


  #   pg_centroid = ActiveRecord::Base.connection.execute(sql)

  #   return pg_centroid.values[0][0]
  # end

  # def strip_point_lable
  #   self.sub("POINT (", '').sub(')', '')
  # end



  private

  def subtract_current_user(current_user_id)
    @dogs -= Dog.where(owner_id: current_user_id)
    @neighbors -= [User.find_by(id: current_user_id)]
    @walks -= Walk.where(user_id: current_user_id)

  end

end
