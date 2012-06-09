class TeamsController < ApplicationController
  skip_before_filter :require_login, :only => [:dashboard]
  def dashboard
    unless current_user
      redirect_to welcome_path() 
      return
    end

    @bugs = current_team.bugs.not_rcaed.not_ignored.order("created_at DESC")
    @followups = current_team.followups.not_completed.order("expected_date")
  end

  def refresh
    current_team.pull_bugs
    flash[:notice] = "Import from PT has been successful"
    redirect_to request.referer
  end

end
