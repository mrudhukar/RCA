class User < ActiveRecord::Base
  acts_as_authentic

  has_many :team_users, :dependent => :destroy
  has_many :teams, :through => :team_users
  has_many :followups, :dependent => :destroy

  validates :name, :presence => true
end
