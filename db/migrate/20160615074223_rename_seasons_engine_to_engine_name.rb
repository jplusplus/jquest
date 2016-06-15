class RenameSeasonsEngineToEngineName < ActiveRecord::Migration
  def change
    rename_column :seasons, :engine, :engine_name
  end
end
