class UserSerializer < ActiveModel::Serializer
  attributes  :id, :email, :email_md5,
              :created_at, :updated_at,
              :consumed_timestep, :otp_required_for_login,
              :role, :phone_number
end
