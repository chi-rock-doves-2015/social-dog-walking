#need to get current geolocation data


class LocalArea
  attr_reader :marks, :users

  def inititialize(latitude, longitude)

    sql = "SELECT * FROM marks WHERE ST_DWithin(coords, #{point}, 1000);"

  end
end