class Bug < ActiveRecord::Base
  belongs_to :team

  has_many :root_cause_bugs, :dependent => :destroy
  has_many :root_causes, :through => :root_cause_bugs, :order => "root_cause_bugs.id asc"

  validates :team, :pt_id, :title, :presence => true

  scope :not_rcaed, where(:conducted_at => nil)
  scope :ignored, where(:ignored => true)
  scope :not_ignored, where(:ignored => false)

  def rca_done?
    conducted_at.present?
  end

  def label_list
    labels.downcase.split(",").reject{|l| l=="rca"}
  end

	def has_root_cause?
		root_causes.present?
	end
end
