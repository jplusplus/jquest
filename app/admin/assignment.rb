ActiveAdmin.register Assignment do
  permit_params :user_id, :season_id, :resource_id, :resource_type, :expires_at
  belongs_to :user, :optional => true

  form do |f|
    f.inputs "Details" do
      f.input :user
      f.input :season
      f.input :resource_type, as: :select, collection: Assignment::resource_types
      f.input :resource_id
      f.input :expires_at, as: :datepicker
    end
    f.actions
  end
end
