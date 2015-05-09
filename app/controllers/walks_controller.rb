class WalksController < ActionController::Base
  def create
    @walk = Walk.create()
    redirect_to @walk
  end

  def show
    walk = Walk.find_by(id: params[:id])
    marks = walk.marks

    render json: emails
  end
end
