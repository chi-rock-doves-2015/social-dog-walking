class WalksController < ActionController::Base
  def create
	# user = User.find_by(id: session[:id])
      @walk = Walk.new(user_id: session[:user_id])
      @walk.marks << Mark.create!(mark_params)
      session[:walk_id] = @walk.id

      # redirect_to @walk

      redirect_to walk_path(@walk)
      # render '_buttons'
    # keeps user who created walk logged into walk until walk
    # is ended.
    #   @errors = @walk.errors
    #   redirect_to :back
    
  end

  def show
    @walk = Walk.find(params[:id])
  end

  private
    def mark_params
      params.require(:mark).permit(:accuracy, :latitude, :longitude)
    end
end
