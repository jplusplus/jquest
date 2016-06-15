class School < ActiveRecord::Base
  has_many :users

  def country_name
    @country_name ||= ISO3166::Data.new(country).call['name']
  end
end
