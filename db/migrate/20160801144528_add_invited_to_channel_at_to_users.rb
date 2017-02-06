class AddInvitedToChannelAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :invited_to_channel_at, :datetime
    add_column :users, :invited_to_channel_as, :string, default: ""
  end
end
