class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def show
    puts "PARAPAAMAS"
    puts params
    @user = User.find_by(id: params[:id])
  end

  def update
  end

  def delete
  end

  private
    def user_params
       params.require(:user).permit(:username, :email, :avatar, :password)
    end
end
