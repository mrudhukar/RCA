class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.validate_password_field = false
    # config.merge_validates_confirmation_of_password_field_options :if => :token_blank
    # config.merge_validates_length_of_password_field_options :if => :token_blank
  end

  attr_protected :token

  has_many :team_users, :dependent => :destroy
  has_many :teams, :through => :team_users
  has_many :followups, :dependent => :nullify

  validates :name, :presence => true

  # def token_blank
  #   self.token.blank?
  # end

  def update_user_from_token!(token, email)
    PivotalTracker::Client.token = token
    project = PivotalTracker::Project.all.select{|p| !p.use_https}.first
    memberships = project.memberships.all
    self.name = memberships.select{|u| u.email == email}[0].name
    self.email = email
    self.token = token
    self.save!
  end

end
