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
    user = current_user
  	dashboard_json = user.as_json(:only => [:id, :username]).merge(
        distanceTraveled: user.distance_traveled,
        distanceScore: user.distance_score,
        area: user.area,
        image_url: user.avatar.url(:thumb))

      if user.walks.any?
        dashboard_json[:walks] = user.walks.map do |walk|
          walk.marks.map do |mark|
            [mark.longitude, mark.latitude]
          end
        end
      end


      # insert dogs
      if user.dogs.any?
        dashboard_json[:dogs] = user.dogs.map do |dog|
          dog.as_json.merge(
            distanceTraveled: dog.distance_traveled,
            distanceScore: dog.distance_score,
            area: dog.area,
            image_url: dog.avatar.url(:thumb)
            )
        end
      end

    if user.marks.any?
      dashboard_json[:centroid] = user.centroid_to_LatLng.as_json
      neighborhood = user.neighbors
      # insert neighbors, including their scores, dogs, and walks/marks of both :/
      dashboard_json[:neighbors] = neighborhood.neighbors.map do |neighbor|
        neighbor.as_json(:only => [:id, :username]).merge(
          distanceTraveled: neighbor.distance_traveled,
          distanceScore: neighbor.distance_score,
          area: neighbor.area,
          image_url: neighbor.avatar.url(:thumb)
          )
      end





      dashboard_json[:neighbors].each do |neighbor|
        # if neighbor.walks.any?
          neighbor["walks"] = neighborhood.walks.select { |walk| walk.user_id == neighbor["id"]}
          neighborhood.marks.each{|m| puts "#{m.latitude} #{m.longitude}"}
          neighbor["walks"].map! do |walk|
            neighborhood.marks.select { |mark| mark.walk_id == walk["id"] }.map { |mark| [mark.longitude, mark.latitude]}
          end
          neighbor["walks"].each {|walk| puts [walk]}
        # end

        # if neighbor.dogs.any?
          neighbor[:dogs] = neighborhood.dogs.select { |dog| dog.owner_id = neighbor["id"] }
          neighbor[:dogs].map! do |dog|
              dog.as_json.merge(
                distanceTraveled: dog.distance_traveled,
                distanceScore: dog.distance_score,
                area: dog.area,
                image_url: dog.avatar.url(:thumb)
                )
            end
          end
    end

    puts dashboard_json[:neighbors]

    return dashboard_json
  end


  def current_user
    @_current_user ||= User.find_by(id: session[:user_id])
  end


  # This needs to be better. doesn't clear backbone's # !!!
  def require_login
    redirect_to '/' unless current_user
  end



end
