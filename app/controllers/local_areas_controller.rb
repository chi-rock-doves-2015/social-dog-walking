class LocalAreasController < ApplicationController
  # AJAX get request
  # local_areas 
  def show
    # @local_area = LocalArea.new(params[:latitude], params[:longitude])
    # puts "*******"
    # puts @local_area.users
    # @local_area.users.each do |user|
    #   puts user
    #   puts user.inspect
    # end
    if request.xhr?
      geojson = TerritoriesHelper.geojson(@local_area.users, "Polygon")
      puts geojson
      render json: geojson
    else
      render render :nothing => true, status: 404
    end
  end
end
