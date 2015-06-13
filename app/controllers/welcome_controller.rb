class WelcomeController < ApplicationController
  def index
    if current_user
      redirect_to '/dashboard/#backbone'
    end
  end

  def map_sandbox

  	unless Rails.env.development?
  		flash[:alert] = "Production area only"
  		redirect_to '/'
  	end
		flash[:alert] = "Welcome to Warp Zone"

  end
end
