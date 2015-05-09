class WalksController < ActionController::Base
  def create
  	user = User.find_by(id: session[:id])
    @walk = Walk.create(user: user)
    # keeps user who created walk logged into walk until walk
    # is ended. 
    session[:walk_id] = @walk.id

    puts @walk
    # redirect_to @walk
    render '_buttons'
  end

  def show

  end
end