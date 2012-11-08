class Followup < ActiveRecord::Base
  module Status
    NOT_STARTED = 0
    SCHEDULED = 1
    STARTED = 2
    COMPLETED = 3

    def self.all
      [NOT_STARTED, SCHEDULED, STARTED, COMPLETED]
    end
  end

  belongs_to :root_cause
  belongs_to :user

  validates :user, :presence => {:on => :create}
  validates :root_cause, :title, :presence => true
  validates :status, :inclusion => {:in => Status.all}

  scope :not_completed, where(:status => [Status::NOT_STARTED, Status::SCHEDULED, Status::STARTED])

  def team
    self.root_cause.team
  end

  def add_pt_story
    PivotalTracker::Client.token = self.team.token
    project = PivotalTracker::Project.find(self.team.project_id)
    a = project.stories.create(:name => self.title, :story_type => 'feature', :description => self.description, :owned_by => self.user.try(:name))

    self.update_attributes!(:pt_id => a.id)
  end

end
