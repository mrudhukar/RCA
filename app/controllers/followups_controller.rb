class FollowupsController < ApplicationController

  def new
    @root_cause = RootCause.find(params[:root_cause_id])
    @followup = current_team.followups.new(:root_cause => @root_cause)
  end

  def create
    @followup = current_team.followups.new(params[:followup])
    @followup.save!
    flash[:notice] = "The followup has been created"
    redirect_to request.referer
  end

  def edit
    @followup = current_team.followups.find(params[:id])
    @state_change = params[:status].present?
  end

  def update
    @followup = current_team.followups.find(params[:id])
    @followup.update_attributes!(params[:followup])
    flash[:notice] = "The follow up has been updated"
    redirect_to request.referer
  end

  def destroy
    @followup = current_team.followups.find(params[:id])
    @followup.destroy
    flash[:notice] = "The follow up has been removed"
    redirect_to request.referer
  end

end
