class CreateActivities < ActiveRecord::Migration[5.0]
  def change
    # Activities are used to record user's actions such as viewing a tutorial
    # or adding a contribtion during a season. The sum of there point gives
    # you the total points a user accumulate during for each season.
    create_table :activities do |t|
      # All action are relation to a user AND a season
      t.references :user, index: true, foreign_key: true
      t.references :season, index: true, foreign_key: true
      # ID of the resource this action is related to
      t.references :resource, polymorphic: true
      # Type of the resource this action is related to
      t.string :resource_type
      # This action might change the user total points
      t.integer :points, default: 0
      # A category describing this action
      t.string :taxonomy

      t.timestamps null: false
    end
  end
end
