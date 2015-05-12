module MarksHelper

  def self.geojson(walk, geotype)
    if geotype == 'Point'
      features = Array.new
      walk.marks.each do |mark|
         features << {
          type: "Feature",
          geometry: {
            type: geotype,
            coordinates: [mark.coords.x, mark.coords.y]
          }
        }
      end

    else
      coordinates = Array.new

      walk.marks.each do |mark|
        coordinates << [mark.longitude.to_f, mark.latitude.to_f]
      end

      features = [{
          type: "Feature",
          geometry: {
            type: geotype,
            coordinates: [coordinates]
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
