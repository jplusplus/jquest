class AddValueToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :value, :string
  end
end
