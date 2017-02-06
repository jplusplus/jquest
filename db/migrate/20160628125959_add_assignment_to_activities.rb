class AddAssignmentToActivities < ActiveRecord::Migration[5.0]
  def change
    add_reference :activities, :assignment, index: true, null: true
  end
end
