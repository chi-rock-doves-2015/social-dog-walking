class LocalAreasController < ApplicationController
  def show
    # current_position = Mark.new(coords: 'POINT #{params[:latitude]} params[:longitude]')

    # puts "CURRENT POSITION"
    # puts current_position
    puts params
    lat = params[:latitude]
    lon = params[:longitude]

    puts lat
    puts lon

    point = "'POINT " + lat.to_s + " " + lon.to_s + "'"

    puts point


    sql = "SELECT * FROM marks WHERE ST_DWithin(coords, #{point});"
    puts sql

    #   geography(marks), 50)"

    records_array = ActiveRecord::Base.connection.execute(sql)

    puts records_array

    @marks = records_array.map do |mark_data|
      Mark.new(mark_data)
    end


    # sql = "SELECT * FROM marks WHERE ST_DWithin(ST_GeogFromText('SRID=4326;POINT(-3.165356 55.926665)'),
    # puts local_marks
  end
end
