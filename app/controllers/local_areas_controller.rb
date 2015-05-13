class LocalAreasController < ApplicationController
  def show
    local_area = LocalArea.new(params[:latitude], params[:longitude])
    # current_position = Mark.new(coords: 'POINT #{params[:latitude]} params[:longitude]')

    # puts "CURRENT POSITION"
    # puts current_position
    puts params
    # lat = params[:latitude]
    # lon = params[:longitude]

    # puts "LAT"
    # puts lat

    # puts "LON"
    # puts lon

    # point = "'POINT " + "(" + lat.to_s + " " + lon.to_s + ")" + "'"
    # puts "POINT"
    # puts point

    # sql = "SELECT * FROM marks WHERE ST_DWithin(coords, 'POINT (41.889452299999995 -87.63730059999999)', 1000);"

    # puts "QUERY"
    # puts sql
    # puts "QUERY TEXT DONE"

    # records_array = ActiveRecord::Base.connection.execute(sql)

    # puts records_array

    # @marks = records_array.map do |mark_data|
    #   Mark.new(mark_data)
    # end


    # sql = "SELECT * FROM marks WHERE ST_DWithin(ST_GeogFromText('SRID=4326;POINT(-3.165356 55.926665)'),
    # puts local_marks
  end
end
