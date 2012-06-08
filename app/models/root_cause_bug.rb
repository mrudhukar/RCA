class RootCauseBug < ActiveRecord::Base
  belongs_to :root_cause, :counter_cache => true
  belongs_to :bug, :counter_cache => true

  validates :bug, :root_cause, :presence => true
  validates :bug_id, :uniqueness => {:scope => :root_cause_id}
end
