class DogsController < ApplicationController

  def new
    @user = User.find_by(id: params[:user_id])
    @dog = Dog.new
    @dog.owner_id = params[:user_id]
  end

  def create
    puts "DOG PARAMS"
    puts params

    @dog = Dog.new(dog_params)
    @dog.owner_id = params[:user_id]
    if @dog.save
      redirect_to dog_path(@dog)
    else
      @errors = @dog.errors.full_messages
      render 'new'
    end
  end

  def edit
    @dog = Dog.find_by(id: params[:id])
  end

  def update
    @dog = Dog.find_by(id: params[:id])
    @dog = @dog.update(dog_params)
    redirect_to dog_path
  end

  def show
    @dog = Dog.find(params[:id])
  end

  private
  def dog_params
     params.require(:dog).permit(:name, :breed, :birthday, :avatar)
  end


end
