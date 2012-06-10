class TeamsController < ApplicationController
  skip_before_filter :require_login, :only => [:dashboard]
  def dashboard
    unless current_user
      redirect_to welcome_path() 
      return
    end

    if current_team
      @bugs = current_team.bugs.not_rcaed.not_ignored.order("created_at DESC")
      @followups = current_team.followups.not_completed.order("expected_date")
    else
      redirect_to edit_user_path(current_user)
    end
  end

  def refresh
    current_team.pull_bugs
    flash[:notice] = "Import from PT has been successful"
    redirect_to request.referer
  end

  def create
    team = Team.create!(params[:team].slice(*[:title, :token, :project_id]))
    team.team_users.create!(:user => current_user, :admin => true)
    flash[:notice] = "Your team has been created."
    redirect_to root_path
  end

  def update
    team = current_user.teams.find(params[:id])
    if params[:add_members]
      email = params[:team][:users]
      user = User.find_by_email(email)
      team.users << user
      flash[:notice] = "Member has been updated to the team."
    else
      team.update_attributes!(params[:team].slice(*[:title, :token, :project_id]))
      flash[:notice] = "Your team has been updated."
    end
    redirect_to root_path
  end

end
