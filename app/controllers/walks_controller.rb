class WalksController < ApplicationController

  def index
    # recent walks will be in this route
    # current_user stuff
    walks = Array.new

  end

  def new
    #for taking a walk and choosing your dogs; also allows http request easier
  end

  def create
    @walk = Walk.create(user: current_user)
    session[:walk_id] = @walk.id

    # Not plotting a mark on start for the time being
    # @walk.marks << Mark.create!(mark_params)
    # session[:walk_id] = @walk.id

    # redirect_to @walk
    if request.xhr?
      render "walk_in_progress"
    end

    # redirect_to ""
    # A restful route could be added here
  end

  def show
    #!needs current user validation
    @walk = Walk.find_by(id: params[:id])

    if @walk
      if request.xhr?
        geojson = MarksHelper.geojson(@walk)
        render json: geojson
      else
        render "show"
      end
    else
      render :nothing => true, status: 404
    end
  end

  def end_walk
    puts "WORD I AM IN THE DELETE SESSION"
    @walk = Walk.find_by(id: session[:walk_id])
    session[:walk_id] = nil
    redirect_to @walk
  end
end
