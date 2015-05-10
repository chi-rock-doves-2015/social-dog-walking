module MarksHelper

  def self.geojson(walk)
    features = Array.new
    walk.marks.each do |mark|
       features << {
        type: "Feature",
        geometry: {
          type: "Point",
          coordinates: [mark.longitude.to_f, mark.latitude.to_f]
        },
        # properties: {
        # }
      }
    end

    geojson = {
      type: "FeatureCollection",
      features: features
    }

    return geojson
  end

end

