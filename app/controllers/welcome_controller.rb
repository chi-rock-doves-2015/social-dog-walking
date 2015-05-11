class WelcomeController < ApplicationController
  def map_sandbox
  	if session[:user_id]
  		redirect_to '/dashboard'
  	else
	  	unless Rails.env.development?
	  		flash[:alert] = "Production area only"
	  		redirect_to '/'
	  	end
  		flash[:alert] = "Welcome to Warp Zone"
  	end
  end
end
