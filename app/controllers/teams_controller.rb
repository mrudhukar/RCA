class TeamsController < ApplicationController
  skip_before_filter :require_login, :only => [:dashboard]
  def dashboard
    redirect_to welcome_path() unless current_user

    @bugs = current_team.bugs.not_rcaed.not_ignored.order("created_at DESC")
    @followups = current_team.followups.not_completed.order("expected_date")
  end

  def refresh
    current_team.pull_bugs
    flash[:notice] = "Import from PT has been successful"
    redirect_to request.referer
  end

end
