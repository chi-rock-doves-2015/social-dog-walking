class LocalAreasController < ApplicationController
  def show
    @local_area = LocalArea.new(params[:latitude], params[:longitude])
    puts "*******"
    puts @local_area.users
    @local_area.users.each do |user|
      puts user
      puts user.inspect
    end
    puts "*******"
    # @local_area_users = local_area.users
    # puts "LOCALAREAUSERS"
    # puts @local_area_users
  end
end
