class WalksController < ActionController::Base
  def create
    @walk = Walk.create()
    redirect_to @walk
  end

  def show
    walk = Walk.find_by(id: params[:id])

    if walk
      features = Array.new
      puts walk.marks[0].longitude
      walk.marks.each do |mark|
         features << {
          type: "Feature",
          geometry: {
            type: "Point",
            coordinates: [mark.longitude.to_f, mark.latitude.to_f]
          },
          properties: {
            # name:
            # address:
            :"marker-color" => "#00607d",
            :"marker-symbol" => "circle",
            :"marker-size" => "medium"
          }
        }
      end

      geojson = {
        type: "FeatureCollection",
        features: features
      }

      puts geojson

      render json: geojson

    else
      render :nothing => true, status: 404
    end
  end

end
