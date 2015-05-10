class WalksController < ActionController::Base
  def create
  	# user = User.find_by(id: session[:id])
    @walk = Walk.new(user_id: params[:user_id])
    # keeps user who created walk logged into walk until walk
    # is ended.
    if @walk.save
      # @walk.marks << Mark.create!(mark_params)

    session[:walk_id] = @walk.id

      if request.xhr?


  def show
    walk = Walk.find_by(id: params[:id])

        # redirect_to @walk
        render '_buttons'
      end
      redirect_to walk_path(@walk)
    else
      @errors = @walk.errors
      redirect_to :back
    end


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
  # private
  #   def mark_params
  #     params.require(:mark).permit(:accuracy, :latitude, :longitude)
  #   end
end
