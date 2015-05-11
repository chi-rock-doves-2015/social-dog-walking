module UsersHelper

  def self.geojson(walks, geotype)
    coordinates = Array.new

    walks.each do |walk|
      walk.marks.each do |mark|
        coordinates << [mark.longitude.to_f, mark.latitude.to_f]
      end
    end

      features = [
        { type: "Feature",
          geometry: { type: geotype, coordinates: [coordinates] },
          properties: { }
        }
      ]

    geojson = { type: "FeatureCollection",
                features: features
              }

    puts geojson

    return geojson
  end

end
