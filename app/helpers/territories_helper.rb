module TerritoriesHelper

  def self.geojson(users, geotype)

    features = Array.new

      users.each do |marks|
        coordinates = Array.new
        marks.each do |mark|
          coordinates << [mark.longitude, mark.latitude]
        end
        coordinates << [marks.first.longitude, marks.first.latitude]

        features << {
            type: "Feature",
            geometry: {
              type: geotype,
              coordinates: [coordinates]
            }
          }
      end

    geojson = { type: "FeatureCollection",
                features: features
              }

    puts geojson

    return geojson
  end

end

