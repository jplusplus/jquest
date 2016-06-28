class AddAssignmentToActivities < ActiveRecord::Migration
  def change
    add_reference :activities, :assignment, index: true, null: true
  end
end
