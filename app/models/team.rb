class Team < ActiveRecord::Base
  attr_accessible :title

  has_many :followups, :dependent => :destroy
  has_many :bugs, :dependent => :destroy

  validates :title, :project_id, :token, :presence => true

  def pull_bugs
    PivotalTracker::Client.token = self.token
    project = PivotalTracker::Project.find(self.project_id)

    rca_bugs = project.stories.all(:label => 'rca', :story_type => ['bug'], :includedone => true)
    rca_bugs.each do |ptbug|
      self.bugs.find_by_pt_id(ptbug.id) || self.bugs.create!(:pt_id => ptbug.id, :title => ptbug.name, :description => ptbug.description)
    end
  end
end
