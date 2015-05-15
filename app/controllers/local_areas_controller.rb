class LocalAreasController < ApplicationController
  def create
    if request.xhr?
      @local_area = LocalArea.new(params["latitude"], params["longitude"])
      geojson = LocalAreasHelper.geojson(@local_area.users, "Polygon")
      render json: geojson
    else
      render render :nothing => true, status: 404
    end
  end
end
