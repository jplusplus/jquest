class AddInvitationDescriptionToSeasons < ActiveRecord::Migration[5.0]
  def change
    add_column :seasons, :invitation_description, :text
  end
end
