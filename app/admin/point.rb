ActiveAdmin.register Point do
  permit_params :user_id, :season_id, :level, :round
  menu label: 'Progressions', parent: 'Team'
  belongs_to :user, :optional => true

  index do
    selectable_column
    id_column
    column :user
    column :season
    column :level
    column :round
    column :value
    actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :user
      f.input :season
      f.input :level
      f.input :round
    end
    f.actions
  end
end
