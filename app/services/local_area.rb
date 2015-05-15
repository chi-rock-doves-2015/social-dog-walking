class LocalArea
  attr_reader :marks, :neighbors, :dogs

  def initialize(lat, lon, current_user)
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

    @dogs -= current_user.dogs
    @neighbors -= [current_user]

  end
end
