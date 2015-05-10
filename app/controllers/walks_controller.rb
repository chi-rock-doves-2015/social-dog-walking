class WalksController < ApplicationController

  def index
    # recent walks will be in this route
    # current_user stuff
    walks = Array.new

  end

  def create
    @walk = Walk.create(user: current_user)
    # keeps user who created walk logged into walk until walk
    # is ended.

    #Not plotting a mark on start for the time being
    # @walk.marks << Mark.create!(mark_params)
    # session[:walk_id] = @walk.id

    # redirect_to @walk
    if request.xhr?
      render "walk_in_progress", layout: false
    end
  end

  def show
    #!needs current user validation
    walk = Walk.find_by(id: params[:id])

    if walk
      features = Array.new
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
