class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def dashboard_json_constructor
  	dashboard_json = current_user.as_json.merge(
        distanceTraveled: current_user.distance_traveled, 
        distanceScore: current_user.distance_score, 
        area: current_user.area)
    neighborhood = current_user.neighbors

    # insert dogs
    dashboard_json[:dogs] = current_user.dogs.map do |dog|
      dog.as_json.merge(
        distanceTraveled: dog.distance_traveled, 
        distanceScore: dog.distance_score, 
        area: dog.area
        )
    end

    # insert neighbors, including their scores, dogs, and walks/marks of both :/
    dashboard_json[:neighbors] = neighborhood.neighbors.map do |neighbor|
      neighbor.as_json.merge(
        distanceTraveled: neighbor.distance_traveled,
        distanceScore: neighbor.distance_score
        )
    end

    dashboard_json[:neighbors].each do |neighbor|
      neighbor[:walks] = neighborhood.walks.select { |walk| walk.user_id = neighbor[:id]}
      neighbor[:walks].map! { |walk| walk.as_json }
        
      neighbor[:dogs] = neighborhood.dogs.select { |dog| dog.owner_id = neighbor[:id] }
      neighbor[:dogs].map! do |dog| 
          dog.as_json.merge(
            distanceTraveled: dog.distance_traveled, 
            distanceScore: dog.distance_score, 
            area: dog.area
            )
        end
    end

    
    puts dashboard_json
    return dashboard_json
      
  end


  def current_user
    @_current_user ||= User.find_by(id: session[:user_id])
  end



end
