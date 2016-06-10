ActiveAdmin.register Season do
  permit_params :name, :primary_color, :status, :engine
  menu label: 'Seasons', priority: 2

  filter :name

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :primary_color
      f.input :status, as: :radio
      f.input :engine, as: :select,  collection: Season::engines_name
    end
    f.actions
  end
end
