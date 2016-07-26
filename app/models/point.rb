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

  def next_level
    update level: level + 1, round: 1
  end

  def next_round
    update round: round + 1
    puts '>>>>>>>>>>>>>>>>>>>> UPDATE ROUND', round
  end

  def reset
    # Remove all activities
    Activity.destroy_all user: user, season: season
    # Remove all assignments
    Assignment.destroy_all user: user, season: season
    # Start over
    update level: 1, round: 1
    # Get new assignments
    season.controller.new.new_assignments! user
  end
end
