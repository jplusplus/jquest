ActiveAdmin.register School do
  permit_params :name, :contact_name, :contact_phone, :contact_email, :country
  menu label: 'Schools', parent: 'Team'

  filter :name
  filter :contact_name
  filter :contact_phone
  filter :contact_email
end
