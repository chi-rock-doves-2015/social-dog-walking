class WalksController < ApplicationController

  def index
    # # recent walks will be in this route
    # # current_user stuff
    # walks = Array.new
    # #?????????????????? what is this for??????????
    @walks = current_user.recent_walks
  end

  def new
    @walk = Walk.new(user_id: current_user.id)
      if request.xhr?
        render "new", layout: false
      end
  end

  def create
    puts params
      @walk = Walk.new(user: current_user)
      if params[:current_user] && params[:current_user][:dog_ids]
            dogs = params[:current_user][:dog_ids]
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
    puts "I AM IN THE WALKS CONTROLLER SHOW METHOD"
    #!needs current user validation
    @walk = Walk.find_by(id: params[:id])

    if @walk
      if request.xhr?
        geojson = MarksHelper.geojson(@walk, "Point")
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
