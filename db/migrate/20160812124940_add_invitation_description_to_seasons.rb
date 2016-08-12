class AddInvitationDescriptionToSeasons < ActiveRecord::Migration
  def change
    add_column :seasons, :invitation_description, :text
  end
end
