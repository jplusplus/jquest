class CreatePoints < ActiveRecord::Migration[5.0]
  def change
    create_table :points do |t|
      # All points are related to a user AND a season
      t.references :user, index: true, foreign_key: true
      t.references :season, index: true, foreign_key: true
      t.integer :value, default: 0
    end
    # One by user and seasons
    add_index :points, [:user_id, :season_id], :unique => true
  end
end
