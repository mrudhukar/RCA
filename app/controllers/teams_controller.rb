class TeamsController < ApplicationController
  skip_before_filter :require_login, :only => [:dashboard]

  before_filter :fetch_team, only: [:refresh, :refresh_members, :show, :team, :edit, :update]

  def dashboard
    unless current_user
      redirect_to welcome_path() 
      return
    end
    session[:team_id] = nil
  end

  def refresh
    @team.pull_bugs(current_user.token)
    flash[:notice] = "Import from PT has been successful"
    redirect_to request.referer
  end

  def refresh_members
    @team.pull_users(current_user.token)
    flash[:notice] = "Import from PT has been successful"
    redirect_to request.referer
  end

  def show
    set_current_team(@team)
    @bugs = @team.bugs_for_rca
    @followups = @team.pending_follups
  end

  def new
    team = Team.new()
  end

  def create
    team = Team.create!(params[:team].slice(*[:title, :token, :project_id]))
    team.team_users.create!(:user => current_user, :admin => true)
    flash[:notice] = "Your team has been created."
    redirect_to root_path
  end

  def edit
    raise unless @team.is_owner?(current_user)
  end

  def update
    raise unless @team.is_owner?(current_user)
    @team.update_attributes!(params[:team].slice(*[:title, :token, :project_id]))
    flash[:notice] = "Your team has been updated."
    redirect_to root_path
  end

  private

  def fetch_team
    @team = current_user.teams.find(params[:id])
  end

end
