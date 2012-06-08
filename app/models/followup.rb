class Followup < ActiveRecord::Base
  belongs_to :root_cause
  belongs_to :team

  has_one :pt_story
  validates :root_cause, :presence => true
end
