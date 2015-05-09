class WalksController < ActionController::Base
  def create
  	# user = User.find_by(id: session[:id])
    @walk = Walk.new(user: params[:user_id])
    # keeps user who created walk logged into walk until walk
    # is ended.
    if @walk.save
      @walk.marks << Mark.create!(mark_params)

    session[:walk_id] = @walk.id

      if request.xhr?

        # redirect_to @walk
        render '_buttons'
      end
      redirect_to walk_path(@walk)
    else
      @errors = @walk.errors
      redirect_to :back
    end

  end

  def show
    @walk = Walk.find(params[:id])
  end

  private
    def mark_params
      params.require(:mark).permit(:accuracy, :latitude, :longitude)
    end
end
