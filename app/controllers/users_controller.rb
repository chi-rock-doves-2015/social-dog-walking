class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_user_dog_path(@user)
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def welcome
    @user = User.find_by(id: params[:id])
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user
      if request.xhr?
        geojson = UsersHelper.geojson(@user.marks, "Polygon")
        render json: geojson
      else
        render "show"
      end
    else
      render :nothing => true, status: 404
    end
  end


  #remove or replace when neighbors view is no longer needed (now) - Local area no longer works this way.
  # def neighbors
  #   if request.xhr?
  #     if mark = current_user.marks.last
  #       @local_area = LocalArea.new(mark.latitude, mark.longitude, current_user.id)
  #     else
  #       @local_area = LocalArea.new(42.255808, -87.549555, current_user.id)
  #     end
  #     neighbors_json = @local_area.neighbors.map do |neighbor|
  #       neighbor.as_json.merge(:distanceTraveled => neighbor.distance_traveled, :distanceScore => neighbor.distance_score, :area => neighbor.area)
  #     end
  #   end

  #   ##hacky- use location later

  #   render json: neighbors_json
  # end

  # def territory
  #   @user = current_user
  #   @users = User.where.not(id: current_user.id)
  #     if request.xhr?
  #       geojson = TerritoriesHelper.geojson(@user, @users, "Polygon")
  #       render json: geojson
  #     else
  #       render :nothing => true, status: 404
  #     end
  # end



  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user = @user.update(user_params)
    redirect_to user_path
  end



  def dashboard
    # if backbone ajax request, build a nested dashboard json object
    if request.xhr?
      render json: dashboard_json_constructor
    else
      # else render dashboard html skeleton
      @user = current_user
      render 'dashboard'
    end

  end

  private
  def user_params
     params.require(:user).permit(:username, :email, :avatar, :password)
  end
end
