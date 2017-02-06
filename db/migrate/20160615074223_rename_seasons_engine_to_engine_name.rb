class RenameSeasonsEngineToEngineName < ActiveRecord::Migration[5.0]
  def change
    rename_column :seasons, :engine, :engine_name
  end
end
