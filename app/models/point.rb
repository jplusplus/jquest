class Point < ActiveRecord::Base
  belongs_to :user
  belongs_to :season

  validates :user, presence: true
  validates :season, presence: true

  before_save :set_value

  def set_value
    write_attribute :value, user.activities.where(season_id: season_id).sum(:points).to_i
  end

  def position
    Rails.cache.fetch("#{cache_key}/position", expires_in: 10.minutes) do
      Point.where(season_id: season_id).where('value > ?', value).distinct.pluck(:value).length + 1
    end
  end

  def next_level
    update level: level + 1, round: 1
    # Mark all pending assignments as done
    user.assignments.pending.where(season_id: season_id).update_all status: :done
    # Set new assignments
    season.controller.new.new_assignments! user
  end

  def next_round
    update round: round + 1
  end

  def reset!
    # Remove all activities
    Activity.destroy_all user: user, season_id: season_id
    # Remove all assignments
    Assignment.destroy_all user: user, season_id: season_id
    # Start over
    update level: 1, round: 1
    # Get new assignments
    season.controller.new.new_assignments! user
  end
end
