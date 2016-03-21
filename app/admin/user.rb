ActiveAdmin.register User do
  active_admin_import
  permit_params :email, :phone_number, :password, :password_confirmation,
                :otp_required_for_login,
                :role, :created_at, :updated_at, :confirmed_at,
                school_ids: []

  index do
    selectable_column
    id_column
    column :email
    column :phone_number
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  show :title => proc{|user| user.email }

  filter :email
  filter :phone_number
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :phone_number
      f.input :role, as: :select, collection: User.roles.keys
      f.input :otp_required_for_login, as: :boolean
      f.input :confirmed_at, as: :datepicker
      f.input :schools, :as => :select, :input_html => {:multiple => true}
    end
    f.actions
  end
end
