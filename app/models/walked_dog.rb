class WalkedDog < ActiveRecord::Base
  belongs_to :dog
  belongs_to :walk

end
