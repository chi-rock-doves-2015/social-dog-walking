class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  def convert_collection_to_json!(collection)
    collection.map! {|item| item.as_json}
  end

##what about current user?!

  def dashboard_json_constructor
  	dashboard_json = current_user.as_json.merge(
        distanceTraveled: current_user.distance_traveled,
        distanceScore: current_user.distance_score,
        area: current_user.area,
        centroid: current_user.centroid_to_LatLng.as_json)
    neighborhood = current_user.neighbors

    dashboard_json[:walks] = current_user.walks.map do |walk|
      walk.marks.map do |mark|
        [mark.latitude, mark.longitude]
      end
    end

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
        distanceScore: neighbor.distance_score,
        area: neighbor.area
        )
    end





    dashboard_json[:neighbors].each do |neighbor|

      neighbor["walks"] = neighborhood.walks.select { |walk| walk.user_id == neighbor["id"]}
      neighbor["walks"].map! do |walk|
        neighborhood.marks.select { |mark| mark.walk_id == walk["id"] }.map { |mark| [mark.latitude, mark.longitude]}
      end

      neighbor[:dogs] = neighborhood.dogs.select { |dog| dog.owner_id = neighbor["id"] }
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
