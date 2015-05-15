class LocalArea
  attr_reader :marks, :neighbors, :dogs

  def initialize(lat, lon, current_user_id)
    point = "'POINT " + "(" + lat.to_s + " " + lon.to_s + ")" + "'"

    sql = "SELECT * FROM marks WHERE ST_DWithin(coords, #{point}, 1000);"

    marks_object = ActiveRecord::Base.connection.execute(sql)

    @marks = marks_object.map do |mark_data|
      Mark.new(mark_data)
    end

    @neighbors = @marks.map do |mark|
      mark.walk.user
    end.uniq.compact

    @dogs = @marks.map do |mark|
      mark.walk.dogs
    end.flatten.compact.uniq

    subtract_current_user(current_user_id)

  end


  private

  def subtract_current_user(current_user_id)
    @dogs -= Dog.where(owner_id: current_user_id)
    @neighbors -= [User.find_by(id: current_user_id)]
  end

end
