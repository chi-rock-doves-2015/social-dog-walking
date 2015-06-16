module Geoqueries

  def centroid

    coords = self.marks.map {|mark| "#{mark.longitude} #{mark.latitude}"}
    coords = coords.join(", ")
    puts coords #!!!

    sql = "SELECT ST_AsText(ST_Centroid('MULTIPOINT ( " + coords +" )'));"
    puts sql

    pg_centroid = ActiveRecord::Base.connection.execute(sql)

    return pg_centroid.values[0][0].insert(5, " ")

  end

  def centroid_to_LatLng
    array = self.centroid.sub("POINT (", '').sub(')', '').split(" ")
    lat_lng = {"lat" => array[1].to_f, "lng" => array[0].to_f}.as_json
  end


  def strip_point_label
    self.sub("POINT (", '').sub(')', '')
  end



end
