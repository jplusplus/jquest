class AddAssignmentPendingCountToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :assignment_pending_count, :integer, default: 0
  end
end
