class WalksController < ActionController::Base
  def create
    @walk = Walk.create()
    redirect_to @walk
  end

  def show

  end
end