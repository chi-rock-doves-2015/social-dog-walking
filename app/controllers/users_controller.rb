class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to "/users/#{@user.id}/welcome"
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

  def territory
    @users = User.where.not(id: current_user.id)
      if request.xhr?
        geojson = TerritoriesHelper.geojson(@users, "Polygon")
        render json: geojson
      else
        render :nothing => true, status: 404
      end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user = @user.update(user_params)
    redirect_to user_path
  end

  def delete
  end

  def dashboard
    @user = User.find_by(id: session[:user_id])
    if session[:user_id]
      render 'dashboard'
    else
      redirect_to '/'
    end
  end

  private
  def user_params
     params.require(:user).permit(:username, :email, :avatar, :password)
  end
end
