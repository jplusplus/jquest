module Taxonomiable
  extend ActiveSupport::Concern

  included do
    after_validation :validate_taxonomy

    validates_associated :season
    validates_associated :user

    validates :user, presence: true
    validates :season, presence: true
    validates :taxonomy, presence: true
  end

  private
    def validate_taxonomy
      case taxonomy.upcase
      # Taxonomy used to remember that the user seen the introduction
      when 'INTRO'
        # Look for the very same activity
        if Activity.where(user: user, season: season, taxonomy: taxonomy).exists?
          # It exists! Rollback
          errors.add :base, :duplicated_activity
        end
      end
    end
end
