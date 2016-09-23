class School < ActiveRecord::Base
  has_many :users

  def country_name
    @country_name ||= ISO3166::Data.new(country).call['name']
  end

  def language
    @language ||= ISO3166::Data.new(country).call['languages'].first
  end

  def points
    # Get all points by season
    Point.joins(:user).where(users: {  school_id: id })
  end

  def seasons_points_pairs
    # Low level caching
    @seasons_points_pairs ||=  Rails.cache.fetch("#{cache_key}/seasons_points_pairs", expires_in: 10.minutes) do
      points.pluck(:season_id, :value)
    end
  end

  def season_points(season_id)
    seasons_points_pairs.select{ |pair| pair[0] == season_id }.collect(&:last)
  end

  def points_sum_by_season
    # Low level caching
    Rails.cache.fetch("#{cache_key}/points_sum_by_season", expires_in: 10.minutes) do
      # Get all points by season
      Season.all.pluck(:id).map do |season_id|
        # Create a pair for each season
        [ season_id, season_points(season_id).inject(0, :+) ]
      # Convert the array of pairs to a hash
      end.to_h
    end
  end
end
