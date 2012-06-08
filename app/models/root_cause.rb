class RootCause < ActiveRecord::Base
  attr_accessible :title, :description

  has_many :root_cause_bugs, :dependent => :destroy
  has_many :bugs, :through => :root_cause_bugs

  validates :title, :presence => true
end
