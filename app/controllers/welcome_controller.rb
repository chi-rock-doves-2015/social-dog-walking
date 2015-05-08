class WelcomeController < ApplicationController
  def map_sandbox
  	unless Rails.env.development?
  		flash[:alert] = "Production area only"
  		redirect_to '/'
  	end
  		flash[:alert] = "Welcome to Warp Zone"
  end
end
