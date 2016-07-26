class User < ActiveRecord::Base
  extend Enumerize
  # Include default devise modules. Others available are:
  devise :invitable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :two_factor_authenticatable,
         :otp_secret_encryption_key => ENV['OTP_SECRET_ENCRYPTION_KEY']
         # :database_authenticatable,

  has_many :activities
  has_many :assignments
  has_many :points

  belongs_to :group
  belongs_to :school
  enumerize :role, in: [ :admin, :teacher, :student ], default: :student

  # Ensure the confirmable_at value is set to default
  before_validation(on: :create) do
    self.confirmed_at = DateTime.new
  end

  def to_s
    email || phone_number
  end

  def email_md5
    Digest::MD5.hexdigest email
  end

  def email_anonymised
    (email || '').gsub /[^@.]/, '*'
  end

  def home_country
    @home_country = read_attribute(:home_country)
    if @home_country.blank? and school
      @home_country = school.country
    end
    @home_country
  end

  def spoken_language
    @spoken_language = read_attribute(:spoken_language)
    if @spoken_language.blank? and school
      @spoken_language = school.language
    end
    @spoken_language
  end

  def member_of
    @member_of ||= begin
      unless group.nil?
        group.season
      end
    end
  end

  def password=(p)
    if p
      super
    end
  end

  def password_required?
    false
  end

  def role?(*roles)
    roles.map(&:to_sym).include? role.to_sym
  end

  def reset!
    points.each do |point|
      point.reset!
    end
  end

  def send_two_factor_authentication_code
    #send sms with code!
    p "=> Your OTP code for #{email}:  #{otp_code}"
  end
end
