class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.belongs_to  :owner
      t.string  :name
      t.string  :breed
      t.datetime  :birthday

      t.timestamps null: false
    end
  end
end
