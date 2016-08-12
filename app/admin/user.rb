ActiveAdmin.register User do
  permit_params :email, :phone_number, :password, :password_confirmation,
                :otp_required_for_login, :home_country, :spoken_language,
                :role, :created_at, :updated_at, :confirmed_at, :invitable,
                :school_id, :group_id, :firstname, :lastname, :level

  belongs_to :group, :optional => true
  menu label: 'Users', parent: 'Team'

  active_admin_import({
    validate: false
  })

  batch_action :invite do |ids, inputs|
    User.find(ids).each do |user|
      user.invite!
    end
    redirect_to collection_path, :flash =>{
      :notice =>  ids.length.to_s + ' user'.pluralize(ids.length) + ' invited.'
    }
  end

  batch_action :reset, confirm: "This will remove every activities for the selected user(s)" do |ids, inputs|
    User.find(ids).each do |user|
      user.reset!
    end
    redirect_to collection_path, :flash =>{
      :notice =>  ids.length.to_s + ' user'.pluralize(ids.length) + ' restored.'
    }
  end

  member_action :reset, method: :get do
    resource.reset!
    redirect_to resource_path, notice: "Restored to initial state"
  end

  member_action :invite, method: :get do
    resource.invite!
    redirect_to resource_path, notice: "Invited to jQuest"
  end

  action_item :reset, only: :show do
    link_to 'Reset User', reset_admin_user_path
  end

  action_item :reset, only: :show do
    link_to 'Invite User', invite_admin_user_path
  end

  index do
    selectable_column
    id_column
    column :email
    column :firstname
    column :lastname
    column :phone_number
    column :group
    column :level do |user|
      user.points.find_or_create_by(season: user.member_of).level
    end
    column :round do |user|
      user.points.find_or_create_by(season: user.member_of).round
    end
    column :home_country
    column :spoken_language
    actions
  end

  show :title => proc{|user| user.email }

  filter :email
  filter :firstname
  filter :lastname
  filter :school
  filter :group

  form do |f|
    f.inputs "Details" do
      f.input :email
      f.input :phone_number
      f.input :firstname
      f.input :lastname
      f.input :role, as: :radio
      f.input :otp_required_for_login, as: :boolean
      f.input :home_country
      f.input :spoken_language
      f.input :school_id, :as => :select,  collection: School.all
      f.input :group_id, :as => :select,  collection: Group.all
    end

    f.inputs "Password" do
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  sidebar "Shortcuts", only: [:show, :edit] do
    ul do
      li link_to "Activities",  admin_user_activities_path(user)
      li link_to "Assignments",  admin_user_assignments_path(user)
    end
  end
end
