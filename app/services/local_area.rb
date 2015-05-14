class LocalArea
  attr_reader :marks, :users

  def initialize(lat, lon)
    point = "'POINT " + "(" + lat.to_s + " " + lon.to_s + ")" + "'"

    sql = "SELECT * FROM marks WHERE ST_DWithin(coords, #{point}, 1000);"

    marks_object = ActiveRecord::Base.connection.execute(sql)

    marks = marks_object.map do |mark_data|
      Mark.new(mark_data)
    end

    @users = marks.map do |mark|
      mark.walk.user
    end.uniq
  end
end