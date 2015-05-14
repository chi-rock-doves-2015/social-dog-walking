module WalksHelper

  def walk_in_progress?
    session[:walk_id] == @walk.id
  end

end
