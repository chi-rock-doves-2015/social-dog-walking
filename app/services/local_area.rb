class LocalArea
  attr_reader :marks, :neighbors, :dogs, :walks
  public

  def initialize(marker)

    sql = "SELECT * FROM marks WHERE ST_DWithin(coords, '#{marker.centroid}', 1609);"

    marks_object = ActiveRecord::Base.connection.execute(sql)

    @marks = marks_object.map do |mark_data|
      Mark.new(mark_data)
    end


    # Why compact? #compact removes nils, should not be any here.
    @neighbors = @marks.map do |mark|
      mark.walk.user
    end.uniq.compact

    @walks = @marks.map {|mark| mark.walk }.compact.uniq

    @dogs = @marks.map do |mark|
      mark.walk.dogs
    end.flatten.compact.uniq

    subtract_current_user(marker.id)
  end




  private

  def subtract_current_user(current_user_id)
    @dogs -= Dog.where(owner_id: current_user_id)
    @neighbors -= [User.find_by(id: current_user_id)]
    @walks -= Walk.where(user_id: current_user_id)

  end

end
