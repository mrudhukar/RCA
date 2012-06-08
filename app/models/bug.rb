class Bug < ActiveRecord::Base
  belongs_to :team

  has_many :root_cause_bugs, :dependent => :destroy
  has_many :root_causes, :through => :root_cause_bugs

  has_one :pt_story

  validates :pt_id, :presence => true
end
