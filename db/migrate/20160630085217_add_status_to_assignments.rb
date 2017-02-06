class AddStatusToAssignments < ActiveRecord::Migration[5.0]
  def change
    add_column :assignments, :status, :string, default: "pending", null: false
  end
end
