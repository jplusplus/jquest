ActiveAdmin.register Group do
  permit_params :name, :season_id

  menu label: 'Groups', parent: 'Team'

  filter :name
  filter :season

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :season_id, :as => :select,  collection: Season.all
    end
    f.actions
  end


  sidebar "Group users", only: [:show, :edit] do
    ul do
      li link_to "Users",  admin_group_users_path(group)
    end
  end
end
