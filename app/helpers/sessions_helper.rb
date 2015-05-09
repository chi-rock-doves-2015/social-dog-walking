module SessionsHelper

	def current_user
		puts session
		@_current_user = User.find_by(id: session[:user_id])
		puts "Current user: #{@_current_user.username}" if @_current_user
		return @_current_user
	end
end
