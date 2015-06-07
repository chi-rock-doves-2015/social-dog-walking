class DogsController < ApplicationController

  #Index route for a backbone dog fetch
  def index
    dogs = Dog.where(owner_id: current_user.id)

    dogs_json = dogs.map do |dog|
      dog.as_json.merge(:distanceTraveled => dog.distance_traveled, :distanceScore => dog.distance_score, :area => dog.area)
    end
    puts dogs_json

    render json: dogs_json
  end

  def new
    #may want to change params[:user_id] to session[:user_id] for security
    @user = User.find_by(id: session[:user_id])
    @dog = Dog.new
    flash[:page_message] = "Please tell us about your dog!"
  end

  def create
    @user = User.find_by(id: session[:user_id])
    @dog = Dog.new(dog_params)
    @dog.owner = @user
    if @dog.save
      flash[:alert] = "Dog Created. Good dog, #{@dog.name}!"
      redirect_to dashboard_path
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

  def destroy
    dog = Dog.find_by(id: params[:id])
    dog.destroy
    redirect_to edit_user_path(dog.owner)
  end

  private
    def dog_params
       params.require(:dog).permit(:name, :breed, :birthday, :avatar)
    end

end
