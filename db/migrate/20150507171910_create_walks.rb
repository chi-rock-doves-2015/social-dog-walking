class CreateWalks < ActiveRecord::Migration
  def change
    create_table :walks do |t|
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
