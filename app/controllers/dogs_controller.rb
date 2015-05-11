class DogsController < ApplicationController

  def new
    #may want to change params[:user_id] to session[:user_id] for security
    @user = User.find_by(id: session[:user_id])
    @dog = Dog.new
  end

  def create
    @user = User.find_by(id: session[:user_id])
    @dog = Dog.new(dog_params)
    @dog.owner = @user
    if @dog.save
      redirect_to "/users/#{@user.id}/dogs/#{@dog.id}"
    else
      @errors = @dog.errors.full_messages
      render 'new'
    end
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @dog = Dog.find_by(id: params[:id])
  end

  def update
    @dog = Dog.find_by(id: params[:id])
    @dog = @dog.update(dog_params)
    redirect_to user_dog_path
  end

  def show
    @dog = Dog.find(params[:id])
  end

  private
    def dog_params
       params.require(:dog).permit(:name, :breed, :birthday, :avatar)
    end

end
