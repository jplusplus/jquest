class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :two_factor_authenticatable,
         :otp_secret_encryption_key => ENV['OTP_SECRET_ENCRYPTION_KEY']
         # :database_authenticatable,

  def to_s
    email || phone_number
  end

  def password_required?
    new_record? ? false : super
  end

  def role?(r)
    role.respond_to?(:include?) && role.include?(r.to_s)
  end

  def send_two_factor_authentication_code
    #send sms with code!
    p "=> Your OTP code for #{email}:  #{otp_code}"
  end
end
