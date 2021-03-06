ActiveAdmin.register Assignment do
  permit_params :user_id, :season_id, :resource_id, :resource_type, :expires_at
  belongs_to :user, :optional => true

  scope :all
  scope :pending, ->(scope){ scope.pending }
  scope :done, ->(scope){ scope.done }

  filter :season
  filter :resource_type

  index do
    selectable_column
    id_column
    column :user
    column :status
    column :resource
    column :season
    column :level
    actions
  end

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

  controller do
    def scoped_collection
      super.includes :resource, :season, :user
    end
  end
end
