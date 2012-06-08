class Bug < ActiveRecord::Base
  belongs_to :team

  has_many :root_cause_bugs, :dependent => :destroy
  has_many :root_causes, :through => :root_cause_bugs

  validates :team, :pt_id, :title, :presence => true

  scope :not_rcaed, where(:conducted_at => nil)
  scope :ignored, where(:ignored => true)
  scope :not_ignored, where(:ignored => false)
end
