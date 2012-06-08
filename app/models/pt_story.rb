class PtStory < ActiveRecord::Base
  belongs_to :followup
  belongs_to :bug

  validates :title, :pt_id, :presence => true
end
