class User < ActiveRecord::Base
  extend Enumerize
  # Include default devise modules. Others available are:
  devise :invitable, :confirmable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable,
         :two_factor_authenticatable,
         :otp_secret_encryption_key => ENV['OTP_SECRET_ENCRYPTION_KEY']
  # Eager load user's group
  default_scope { includes(:group) }

  has_many :activities, :dependent => :delete_all
  has_many :assignments, :dependent => :delete_all
  has_many :points, :dependent => :delete_all

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

  def invited_to_channel_at=(value)
    write_attribute :invited_to_channel_as, email
    super
  end

  def invited_to_channel_as_or_email
    invited_to_channel_as || email
  end

  def invited_to_channel?
    invited_to_channel_at? or invited_to_channel_as?
  end

  def email_md5
    Digest::MD5.hexdigest email
  end

  def email_anonymised
    (email || '').gsub /[^@.]/, '*'
  end

  def display_name
    fullname_anonymised || email_anonymised
  end

  def fullname_anonymised
    if firstname.present? and lastname.present?
      firstname.titleize + " " + lastname[0].titleize + "."
    end
  end

  def home_country
    @home_country = read_attribute(:home_country)
    if @home_country.blank? and school
      @home_country = school.country
    end
    @home_country
  end

  def home_country_data
    ISO3166::Data.new(home_country).call or {}
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
      # Get value from the cache
      if ( season = Rails.cache.read "#{cache_key}/member_of" ).nil?
        # Get the season for this group
        season = group.present? ? group.season : nil
        # Different timeout
        expires_in = season ? 10.minutes : 1.minutes
        # Write in cache only for seen course
        Rails.cache.write "#{cache_key}/member_of", season, expires_in: expires_in
      end
      # Return the value
      season
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
