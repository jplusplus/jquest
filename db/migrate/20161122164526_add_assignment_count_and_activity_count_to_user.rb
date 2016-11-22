class AddAssignmentCountAndActivityCountToUser < ActiveRecord::Migration[5.0]

  def up
    # Add the new columns
    add_column :users, :activity_count, :integer, default: 0
    add_column :users, :assignment_count, :integer, default: 0
  end

  def down
    remove_column :users, :activity_count
    remove_column :users, :assignment_count
  end
end
