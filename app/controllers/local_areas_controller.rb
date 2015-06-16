class LocalAreasController < ApplicationController
	def index
	end
	
  def create
    if request.xhr?
      @local_area = LocalArea.new(params["latitude"], params["longitude"], current_user.id)
      geojson = TerritoriesHelper.geojson(current_user, @local_area.neighbors, "Polygon")
      render json: geojson
    else
      render render :nothing => true, status: 404
    end
  end
end
