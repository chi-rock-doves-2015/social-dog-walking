class MarksController < ActionController::Base
  def create
    Mark.create()

    if params[:end] == "true"
      redirect_to :root
    else
      redirect_to :back
    end
  end

end