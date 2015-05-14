module TerritoriesHelper

  def self.geojson(users, geotype)

    features = Array.new

    users.each do |user|
      coordinates = Array.new
      user.marks.each do |mark|
        coordinates << [mark.longitude, mark.latitude]
      end
      coordinates << [user.marks.first.longitude, user.marks.first.latitude]

        features << {
            type: "Feature",
            geometry: {
              type: geotype,
              coordinates: [coordinates]
            },
            properties: {
              geometry: "Polygon",
              shape: "circle",
              color: "yellow"
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
