class EnablePostgis < ActiveRecord::Migration
  def change
    execute <<-SQL
      CREATE EXTENSION postgis;
    SQL
  end
end
