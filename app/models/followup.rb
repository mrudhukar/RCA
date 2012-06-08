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
  belongs_to :team
  belongs_to :user

  validates :root_cause, :team, :title, :presence => true
  validates :status, :inclusion => {:in => Status.all}

  scope :not_completed, where(:status => [Status::NOT_STARTED, Status::SCHEDULED, Status::STARTED])
end
