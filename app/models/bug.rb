class Bug < ActiveRecord::Base
  belongs_to :team

  has_many :root_cause_bugs, :dependent => :destroy
  has_many :root_causes, :through => :root_cause_bugs

  validates :pt_id, :title, :presence => true
end
