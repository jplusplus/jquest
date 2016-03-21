ActiveAdmin.register School do
  active_admin_import
  permit_params :name, :contact_name, :contact_phone, :contact_email

  filter :name
  filter :contact_name
  filter :contact_phone
  filter :contact_email
end
