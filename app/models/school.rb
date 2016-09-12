class School < ActiveRecord::Base
  has_many :users

  def country_name
    @country_name ||= ISO3166::Data.new(country).call['name']
  end

  def language
    @language ||= ISO3166::Data.new(country).call['languages'].first
  end

  def points_by_user
    # Low level caching
    Rails.cache.fetch("#{cache_key}/points_by_user", expires_in: 10.minutes) do      
      users.includes(:points).map(&:points).flatten
    end
  end

  def points_sum_by_season
    # Low level caching
    Rails.cache.fetch("#{cache_key}/points_sum_by_season", expires_in: 10.minutes) do
      # Get all points by season
      points_by_season = points_by_user.group_by(&:season_id)
      # Summerize points value by season
      points_by_season.each do |key, points|
        points_by_season[key] = points.inject(0){ |sum, point| sum + point.value }
      end
    end
  end
end
