class FollowupsController < ApplicationController

  before_filter :fetch_rc

  def new
    @followup = current_team.followups.new()
  end

  def create
    @followup = current_team.followups.new(params[:followup])
    @followup.root_cause = @root_cause
    @followup.save!
    flash[:notice] = "The followup has been created"
    redirect_to request.referer
  end

  def edit
    @followup = current_team.followups.find(params[:id])
  end

  def update
    @followup = current_team.followups.find(params[:id])
    @followup.update_attributes!(params[:followup])
    flash[:notice] = "The followup has been updated"
    redirect_to request.referer
  end

  def destroy
    @followup = current_team.followups.find(params[:id])
    @followup.destroy
    flash[:notice] = "The followup has been removed"
    redirect_to request.referer
  end

  private

  def fetch_rc
    @root_cause = RootCause.find(params[:root_cause_id])
  end
end
