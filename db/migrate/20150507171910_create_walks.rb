class CreateWalks < ActiveRecord::Migration
  def change
    create_table :walks do |t|
      t.time :duration
      t.time :started_at
      t.time :ended_at
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
