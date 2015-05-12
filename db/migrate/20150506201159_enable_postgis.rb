class EnablePostgis < ActiveRecord::Migration
  def change
    execute "CREATE EXTENSION IF NOT EXISTS postgis;"
  end
end
