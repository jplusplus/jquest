module InSeason
  extend ActiveSupport::Concern

  included do
    before_validation :find_season
    validates :season, presence: true
  end

  private
    def find_season
      # If a season is not given explicitely..
      if self.season.nil? and not self.user.nil? and not self.user.member_of.nil?
        # ...we deduce it from the user's group
        self.season = user.member_of
      end
    end
end
