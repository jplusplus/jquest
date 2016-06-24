ActiveAdmin.register Source do
  permit_params :resource_id, :resource_type, :value, :field

  filter :resource_id
  filter :resource_type

  form do |f|
    f.inputs "Details" do
      f.input :resource_type, as: :select, collection: Source::resource_types
      f.input :resource_id
      f.input :field
      f.input :value
    end
    f.actions
  end
end
