module MarksHelper

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
            color: "red"
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
