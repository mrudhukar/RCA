class User < ActiveRecord::Base
  acts_as_authentic

  has_many :team_users, :dependent => :destroy
  has_many :teams, :through => :team_users

  validates :name, :presence => true
end
