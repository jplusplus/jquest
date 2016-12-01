class CountPendingAssignmentsForUser < SeedMigration::Migration
  def up
    # For every users
    User.find_each do |user|
      # Update the new fields
      user.update_attributes! assignment_pending_count: user.assignments.pending.count
    end
  end

  def down
    User.update_all assignment_pending_count: 0
  end
end
