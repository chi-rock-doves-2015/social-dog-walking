module WalksHelper

  def walk_in_progress?
    session[:walk_id] == @walk.id
  end

  def set_color
    @walkcurrent_user.id = user.id ? "red" : "%06x" % (rand * 0xffffff)
  end

  def self.geojson(walk, geotype)
    if geotype == 'Point'
      features = Array.new
      walk.marks.each do |mark|
         features << {
          type: "Feature",
          geometry: {
            type: geotype,
            coordinates: [mark.longitude, mark.latitude]
          },
          properties: {
            geometry: "Point",
            strokeColor: "#ff292c"
          }
        }
      end

    else
      coordinates = Array.new

      walk.marks.each do |mark|
        coordinates << [mark.longitude, mark.latitude]
      end

      coordinates << [walk.marks.first.longitude, walk.marks.first.latitude]

      features = [{
          type: "Feature",
          geometry: {
            type: geotype,
            coordinates: [coordinates]
          },
          properties: {
            geometry: "Polygon",
            color: "#ff292c",
            fillOpacity: 0.5
          }
        }]
    end

    geojson = {
      type: "FeatureCollection",
      features: features
    }

    puts geojson

    return geojson
  end

end
