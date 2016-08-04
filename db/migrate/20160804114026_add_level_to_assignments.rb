class AddLevelToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :level, :integer
  end
end
