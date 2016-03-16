require 'date'

class User
  include Mongoid::Document
  include Mongoid::Timestamps # For c_at and u_at.

  # Include default devise modules. Others available are:
  devise :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :two_factor_authenticatable,
         :otp_secret_encryption_key => ENV['OTP_SECRET_ENCRYPTION_KEY']
         # :database_authenticatable,

  # Wether or not a user can access to the admin panel
  field :role, type: String, default: nil

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :phone_number,       type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  field :locked_at,       type: Time


  field :consumed_timestep,         type:Integer, default: 0
  field :otp_required_for_login,    type:Boolean, default: false
  field :encrypted_otp_secret,      type:String
  field :encrypted_otp_secret_iv,   type:String
  field :encrypted_otp_secret_salt, type:String

  def to_s
    email
  end

  def password_required?
    new_record? ? false : super
  end

  def role?(r)
    !role.nil? && role.include?(r.to_s)
  end

  def send_two_factor_authentication_code
    #send sms with code!
    p "=> Your OTP code for #{email}:  #{otp_code}"
  end
end
