class Mark < ActiveRecord::Base
  belongs_to :walk

  def self.ordered_json
    order("created_at").to_json(methods: :walk_id)
  end

  def longitude
    self.coords.x
  end

  def latitude
    self.coords.y
  end



# !!! I THINK WE CAN DELETE THIS - ES
  # def next
  #   self.walk.marks.where("id > ?", id).first
  # end

  # def prev
  #   self.walk.marks.where("id < ?", id).last
  # end
end

