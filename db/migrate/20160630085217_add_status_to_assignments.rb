class AddStatusToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :status, :string, default: "pending", null: false
  end
end
