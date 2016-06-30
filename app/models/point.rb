class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :season

  validates :user, presence: true
  validates :season, presence: true

  before_save :set_value

  def set_value
    write_attribute :value, user.activities.where(season: season).sum(:points).to_i
  end

  def position
    Point.where(season: season).where('value < ?', value).distinct.pluck(:value).length + 1
  end
end
