class Group < ActiveRecord::Base
  has_many :users
  belongs_to :season

  validates :season, presence: true
end
