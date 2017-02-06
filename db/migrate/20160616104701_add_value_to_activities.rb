class AddValueToActivities < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :value, :string
  end
end
