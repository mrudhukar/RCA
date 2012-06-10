class FollowupsController < ApplicationController

  def index
    @tab = TabConstants::ARCHIVE
    @followups = current_team.followups.order("expected_date").page(params[:page])
  end

  def new
    @root_cause = RootCause.find(params[:root_cause_id])
    @followup = current_team.followups.new(:root_cause => @root_cause)
  end

  def create
    user = User.find_by_name(params[:followup].delete(:user))
    @followup = current_team.followups.new(params[:followup])
    @followup.user = user if user.present?
    @followup.save!
    flash[:notice] = "The followup has been created"
    redirect_to request.referer
  end

  def edit
    @followup = current_team.followups.find(params[:id])
    @state_change = params[:status].present?
  end

  def update
    user = User.find_by_name(params[:followup].delete(:user))
    @followup = current_team.followups.find(params[:id])
    @followup.update_attributes!(params[:followup])
    @followup.user = user if user.present?
    @followup.save!

    flash[:notice] = "The follow up has been updated"
    redirect_to request.referer
  end

  def destroy
    @followup = current_team.followups.find(params[:id])
    @followup.destroy

    flash[:notice] = "The follow up has been removed"
    redirect_to request.referer
  end

  def add_to_pt
    @followup = current_team.followups.find(params[:id])
    @followup.add_pt_story
  end
end
