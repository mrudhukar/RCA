class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :current_team

  before_filter :require_login

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = (current_user_session && current_user_session.record)
  end

  def current_team
    return @current_team if defined?(@current_team)
    @current_team = current_user.teams.find_by_id(session[:team_id])
  end

  def set_current_team(team)
    session[:team_id] = team.id
    @current_team = team
  end

  def require_login
    unless current_user_session
      session[:orginal_uri] = request.url
      redirect_to main_app.login_path
    end
  end
end
