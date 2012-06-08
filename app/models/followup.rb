class Followup < ActiveRecord::Base
  module Status
    NOT_STARTED = 0
    SCHEDULED = 1
    STARTED = 2
    COMPLETED = 3
  end

  belongs_to :root_cause
  belongs_to :team

  validates :root_cause, :team, :title, :presence => true
end
