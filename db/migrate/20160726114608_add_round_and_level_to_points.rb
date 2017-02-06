class AddRoundAndLevelToPoints < ActiveRecord::Migration[5.0]
  def change
    add_column :points, :level, :integer, default: 1
    add_column :points, :round, :integer, default: 1
    # Migrate data
    Point.all.each do |point|
      # Get progression for this
      progression = point.season.controller.new.progression_legacy point.user
      # Update attributes accordingly
      point.update(level: progression.level, round: progression.round)
    end
  end
end
