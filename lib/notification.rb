class Notification < ActiveRecord::Base
	
	def self.remind_followup
    	Followup.not_completed.collect(&:user).uniq.each do |user|
      		not_completed_followups = user.followups.not_completed
      		UserMailer.remind_about_followups(not_completed_followups, user).deliver
    	end
  	end

end