ActiveAdmin.register Activity do
  permit_params :user_id, :season_id, :resource_id, :resource_type, :points, :taxonomy
  belongs_to :user, :optional => true

  filter :season
  filter :user_id

  index do
    selectable_column
    id_column
    column :user
    column :taxonomy
    column :points
    column :value
    column :season
    actions
  end

  form do |f|
    f.inputs "Details" do
      f.input :user
      f.input :season
      f.input :resource_type, as: :select, collection: Activity::resource_types
      f.input :resource_id
      f.input :points
      f.input :taxonomy
    end
    f.actions
  end


  controller do
    def scoped_collection
      super.includes :season, :user
    end
  end
end
