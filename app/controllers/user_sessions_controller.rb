class UserSessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create, :pt_login]

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    @user_session.save ? handle_success : handle_failure
  end

  def pt_login
    email = params[:user_session][:email]
    begin
      token = PivotalTracker::Client.token(email, params[:user_session][:password])
      token_user = User.find_by_token(token)
      email_user = User.find_by_email(email)

      @pt_user = token_user || email_user || User.new(email: params[:user_session][:email])
      if @pt_user.new_record?
        @pt_user.update_user_from_token!(token, @pt_user.email)
      elsif token_user.nil?
        @pt_user.token = token
        @pt_user.save!
        UserSession.create(@pt_user)
      else
        UserSession.create(@pt_user)
      end
      handle_success
    rescue RestClient::Unauthorized
      handle_failure
    end
  end


  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    redirect_to root_url
  end

  private

  def handle_failure
    flash[:error] = "Login failed. Please try again"
    redirect_to login_path
  end

  def handle_success
    redirect_to  root_url
  end
end
