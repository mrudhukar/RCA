class RootCause < ActiveRecord::Base
  belongs_to :team

  has_many :root_cause_bugs, :dependent => :destroy
  has_many :bugs, :through => :root_cause_bugs

  has_many :followups, :dependent => :destroy

  validates :title, :presence => true
end
