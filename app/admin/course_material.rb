ActiveAdmin.register CourseMaterial do
  permit_params :title, :state_name, :state_params, :body,
                :status, :category, :position

  active_admin_import

  scope :all
  scope :draft, ->(scope){ scope.draft }
  scope :published, ->(scope){ scope.published }

  filter :title
  filter :state_name
  filter :status

  config.sort_order = 'position_asc'
  sortable tree: false, sorting_attribute: :position

  index do
    selectable_column
    id_column
    column :title
    column :state_name
    column :status
    actions
  end

  index as: :sortable do
    label :sortable_title
    actions
  end
end
