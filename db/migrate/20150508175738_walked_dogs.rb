class WalkedDogs < ActiveRecord::Migration
  def change
    create_table :walked_dogs do |t|
      t.belongs_to  :walk
      t.belongs_to  :dog
    end
  end
end
