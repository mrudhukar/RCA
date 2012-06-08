class TeamUser < ActiveRecord::Base
  belongs_to :team
  belongs_to :user

  validates :team, :user, :presence => true
  validates :team_id, :uniqueness => {:scope => :user_id}
end
