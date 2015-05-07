class RemoveDurationStartedAtAndEndedAtColumns < ActiveRecord::Migration
  def change
    remove_column :walks, :started_at
    remove_column :walks, :ended_at
    remove_column :walks, :duration
  end
end
