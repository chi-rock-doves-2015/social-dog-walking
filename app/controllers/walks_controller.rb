class WalksController < ActionController::Base
  def create
  	user = User.find_by(id: session[:id])
    @walk = Walk.create(user: user)
    # keeps user who created walk logged into walk until walk
    # is ended.
    @walk.marks << Mark.create!(mark_params)
    session[:walk_id] = @walk.id

    # redirect_to @walk
    render '_buttons'
  end

  def show

  end


  private
    def mark_params
      params.require(:mark).permit(:accuracy, :latitude, :longitude)
    end
end
