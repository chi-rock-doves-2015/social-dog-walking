class WalksController < ApplicationController

  def index
  end

  def new
    @walk = Walk.new(user_id: current_user.id)
      if request.xhr?
        render "new", layout: false
      end

  end

  # For Backbone: 
  def create
    puts params[:dogs]
      @walk = Walk.new(user: current_user)
      if params[:dogs].size > 0
            dogs = params[:dogs]
            puts dogs
            dogs.each {|id| @walk.dogs << Dog.find_by(id: id)}
      end
      if @walk.save
        session[:walk_id] = @walk.id
        if request.xhr?
          render @walk
        else
          redirect_to @walk
        end
      else
        @errors = @walk.errors.full_messages
        redirect_to new_walk_path
      end
  end

  def show
    @walk = Walk.find_by(id: params[:id])
    if @walk
      if request.xhr?
        geojson = WalksHelper.geojson(@walk, "Point")
        render json: geojson
      else
        render "show"
      end
    else
      render :nothing => true, status: 404
    end
  end

  def end_walk
    @walk = Walk.find_by(id: session[:walk_id])
    session[:walk_id] = nil
      # if request.xhr?
      #   geojson = WalksHelper.geojson(@walk, "Point")
      #   render json: geojson
      # else
      redirect_to @walk
        # render "show"
    # if @walk.save
    # else
    #   @errors = @walk.errors
    #   redirect_to dashboard_path
    # end
  end
end
