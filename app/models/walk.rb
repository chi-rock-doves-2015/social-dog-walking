class Walk < ActiveRecord::Base
  belongs_to :user
  has_many   :marks
  has_many   :walked_dogs
  has_many   :users, through: :walked_dogs

  def duration
    updated_at - created_at
  end

  # def self.ordered_json
  #   order("created_at").to_json(methods: :mark_ids)
  # end

  # def mark_ids
  #   self.marks.pluck(:id)
  # end

end
