module TerritoriesHelper

  # def set_color
  #   @walkcurrent_user.id = user.id ? "red" : "%06x" % (rand * 0xffffff)
  # end

  # Build current user's territory as geojson + others' terriertory
  def self.geojson(user, users, geotype)
    features = Array.new
    coordinates = Array.new
    colors = ["#FFFF00", "#9900FF", "#CC6600", "#009933", "#FF00FF", "#669999", "#CC3300", "#FF33CC", "#00CC99", "#333399", "#660066", "#993333", "#996633", "#333300", "#33CCFF"]

    if user.marks.any?
      user.marks.each do |mark|
        coordinates << [mark.longitude, mark.latitude]
      end

    coordinates << [user.marks.first.longitude, user.marks.first.latitude]
    end

      features << {
          type: "Feature",
          geometry: {
            type: geotype,
            coordinates: [coordinates]
          },
          properties: {
            geometry: "Polygon",
            zIndex: 9999,
            fillColor: "#ff292c",
            strokeColor: "#ff292c",
            strokeWeight: 8,
            fillOpacity: 0.5
          }
        }

    users.each do |user|
      coordinates = Array.new
      if user.marks.any?
        user.marks.each do |mark|
          coordinates << [mark.longitude, mark.latitude]
        end
        coordinates << [user.marks.first.longitude, user.marks.first.latitude]
      end
        features << {
            type: "Feature",
            geometry: {
              type: geotype,
              coordinates: [coordinates]
            },
            properties: {
              geometry: "Polygon",
              fillColor: colors.shift,
              strokeWeight: 0,
              fillOpacity: 0.35
              # strokeColor: k.user.id ? "red" : ("#" + ("%06x" % (rand * 0xffffff)).to_s)
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
