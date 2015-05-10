class WalksController < ApplicationController

  def index
    # recent walks will be in this route
    # current_user stuff
    walks = Array.new

  end

  def create
    @walk = Walk.create(user: current_user)
    session[:walk_id] = @walk.id

    # Not plotting a mark on start for the time being
    # @walk.marks << Mark.create!(mark_params)
    # session[:walk_id] = @walk.id

    # redirect_to @walk
    if request.xhr?
      render "walk_in_progress", layout: false
    end

    # redirect_to ""
    # A restful route could be added here
  end

  def show
    #!needs current user validation
    @walk = Walk.find_by(id: params[:id])

    # if walk
    #   features = Array.new
    #   walk.marks.each do |mark|
    #      features << {
    #       type: "Feature",
    #       geometry: {
    #         type: "Point",
    #         coordinates: [mark.longitude.to_f, mark.latitude.to_f]
    #       },
    #       properties: {
    #         # name:
    #         # address:
    #         :"marker-color" => "#00607d",
    #         :"marker-symbol" => "circle",
    #         :"marker-size" => "medium"
    #       }
    #     }
    #   end

    #   geojson = {
    #     type: "FeatureCollection",
    #     features: features
    #   }

    #   puts geojson

    #   render json: geojson

    # else
    #   render :nothing => true, status: 404
    # end
  end

  def end_walk
    puts "WORD I AM IN THE DELETE SESSION"
    @walk = Walk.find_by(id: session[:walk_id])
    session[:walk_id] = nil
    redirect_to @walk
  end
end
