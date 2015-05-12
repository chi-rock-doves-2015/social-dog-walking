module UsersHelper

  def self.geojson(walks, geotype)
    coordinates = Array.new

    walks.each do |walk|
      walk.marks.each do |mark|
        coordinates << [mark.longitude.to_f, mark.latitude.to_f]
      end
      coordinates << [walks.first.marks.first.longitude, walks.first.marks.first.latitude]
    end

      features = [{
          type: "Feature",
          geometry: {
            type: geotype,
            coordinates: [coordinates]
          }
        }]

    geojson = { type: "FeatureCollection",
                features: features
              }

    puts geojson

    return geojson
  end

end
