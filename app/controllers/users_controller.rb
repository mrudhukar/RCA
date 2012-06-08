class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create, :dashboard]
  load_and_authorize_resource

  def new
    # @tab = TabConstants::REGISTER
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.valid?
    captcha_success = verify_recaptcha
    if captcha_success && @user.save
      redirect_to user_url(@user)
    else
      flash.delete(:recaptcha_error)
      flash.now[:error] = "Please re-enter the words from the image again!" unless captcha_success
      # @tab = TabConstants::REGISTER
      render :action => "new"
    end
  end

  def edit
  end

  def update
    user = params[:user].slice(*[:name, :email, :password, :password_confirmation])
    if @user.update_attributes(user)
      redirect_to root_path(), :notice => "Successfully updated your settings"
    else
      render :action => "edit"
    end
  end

  def show
    # @tab = TabConstants::HOME
  end

  def index
  end

end
