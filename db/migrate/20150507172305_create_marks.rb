class CreateMarks < ActiveRecord::Migration
  def change
    create_table :marks do |t|
      t.belongs_to :walk
      t.st_point :coords, geographic: true
      t.integer :accuracy

      t.timestamps null: false
    end
  end
end
