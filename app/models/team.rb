class Team < ActiveRecord::Base
  has_many :team_users, :dependent => :destroy
  has_many :users, :through => :team_users

  has_many :root_causes, :dependent => :destroy
  has_many :followups, :through => :root_causes

  has_many :bugs, :dependent => :destroy

  validates :title, :project_id, :token, :presence => true

  def pull_bugs
    PivotalTracker::Client.token = self.token
    project = PivotalTracker::Project.find(self.project_id)

    rca_bugs = project.stories.all(:label => 'rca', :story_type => ['bug'], :includedone => true)
    rca_bugs.each do |ptbug|
      self.bugs.find_by_pt_id(ptbug.id) || 
      self.bugs.create!(:title => ptbug.name, :description => ptbug.description, :pt_id => ptbug.id, :created_at => ptbug.created_at, :labels => ptbug.labels)
    end
  end

  def is_owner?(user)
    self.team_users.find_by_user_id(user.id).admin?
  end
end
