class UserMailer < ActionMailer::Base
  default from: "rcamadeeasy@chronus.com"

  def remind_about_followups(not_completed_followups, user)
    @user = user
    @not_completed_followups = not_completed_followups
    @recipients = "#{user.name} <#{user.email}>"
    @subject = "Reminder about pending RCA followups"
    @from = "RCA MADE EASY <rcamadeeasy@chronus.com>"
    build_mail(:no_text => true)
  end

  private

  def build_mail(options = {})
  	mail(:to => @recipients, :subject => @subject, :from => @from) do |format|
      format.text unless options[:no_text]
      format.html
    end
  end
end
