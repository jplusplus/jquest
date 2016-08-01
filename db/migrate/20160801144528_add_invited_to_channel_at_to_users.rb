class AddInvitedToChannelAtToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invited_to_channel_at, :datetime
  end
end
