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

  def points
    # All seasons with 0 points by default
    season_ids = Season.all.map { |s| [s.id, 0] }.to_h
    # Merge seasons hash witht the point by season for this user
    season_ids.merge activities.group(:season_id).sum(:points).to_h
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

  def send_two_factor_authentication_code
    #send sms with code!
    p "=> Your OTP code for #{email}:  #{otp_code}"
  end
end
