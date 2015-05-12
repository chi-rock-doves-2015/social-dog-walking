class CreateWalks < ActiveRecord::Migration
  def change
    create_table :walks do |t|
      t.belongs_to :user
      t.st_polygon  :walk_territory

      t.timestamps null: false
    end
  end
end
