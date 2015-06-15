module Geoqueries

  def centroid

    coords = self.marks.map {|mark| "#{mark.longitude} #{mark.latitude}"}
    coords = coords.join(", ")

    sql = "SELECT ST_AsText(ST_Centroid('MULTIPOINT ( " + coords +" )'));"
    puts sql

    pg_centroid = ActiveRecord::Base.connection.execute(sql)

    return pg_centroid.values[0][0].insert(5, " ")

  end

  def centroid_to_LatLng
    array = self.centroid.sub("POINT (", '').sub(')', '').split(" ")
    lat_lng = {"lat" => array[0].to_f, "lng" => array[1].to_f}
  end


  def strip_point_label
    self.sub("POINT (", '').sub(')', '')
  end



end
