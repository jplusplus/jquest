class AddLevelToAssignments < ActiveRecord::Migration[5.0]
  def change
    add_column :assignments, :level, :integer
  end
end
