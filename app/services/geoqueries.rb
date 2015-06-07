module Geoqueries

  def centroid
    
    coords = self.marks.map {|mark| "#{mark.latitude} #{mark.longitude}"}
    coords = coords.join(", ")


    sql = "SELECT ST_AsText(ST_Centroid('MULTIPOINT ( " + coords +" )'));"
    puts sql


    pg_centroid = ActiveRecord::Base.connection.execute(sql)

    return pg_centroid.values[0][0].insert(5, " ")

  end

  def strip_point_lable
    self.sub("POINT (", '').sub(')', '')
  end



end
