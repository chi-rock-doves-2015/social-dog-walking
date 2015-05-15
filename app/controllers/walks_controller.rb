class WalksController < ApplicationController

  def index
  end

  def new
    @walk = Walk.new(user_id: current_user.id)
      if request.xhr?
        render "new", layout: false
      end

  end

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
          flash[:page_message] = "Let's Get Ploppin!"
          redirect_to @walk
        end
      else
        @errors = @walk.errors.full_messages
        redirect_to new_walk_path
      end
  end

  def show
    puts "I AM IN THE WALKS CONTROLLER SHOW METHOD"
    #!needs current user validation
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
    redirect_to @walk
  end
end
