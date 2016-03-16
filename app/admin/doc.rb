ActiveAdmin.register Doc do
  hstore_editor
  permit_params :type, :label, :domain, :content, :user_ids => []

  index do
    selectable_column
    id_column
    column :type
    column :label
    column :domain
    column :content
    column(:users) { |doc|
      (doc.users.all.map :email).join ', '
    }
    actions
  end


  filter :type
  filter :label
  filter :domain
  filter :content

  form do |f|
    f.inputs "Details" do
      f.input :label
      f.input :users
      f.input :type
      f.input :domain
      f.input :content, as: :hstore
    end
    f.actions
  end

  csv do
    column :label
    column(:users) { |doc|
      (doc.users.all.map :email).join ', '
    }
    column :type
    column :domain
    column :content
  end
end
