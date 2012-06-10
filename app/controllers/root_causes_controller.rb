class RootCausesController < ApplicationController

  def new
    @bug = current_team.bugs.find(params[:bug_id])
    @root_cause = RootCause.new()
  end

  def create
    @root_cause = RootCause.create!(params[:root_cause].slice(*[:title, :description]))
    @bug = current_team.bugs.find(params[:bug_id])
    @root_cause.bugs << @bug
    flash[:notice] = "Root Cause has been successfully created"
    redirect_to team_bug_path(current_team, @bug)
  end

  def edit
    @root_cause = RootCause.find(params[:id])
  end

  def update
    root_cause = RootCause.find(params[:id])
    root_cause.update_attributes!(params[:root_cause].slice(*[:title, :description]))
    flash[:notice] = "Root Cause has been successfully updated"
    redirect_to root_cause_path(root_cause)
  end

  def destroy
    root_cause = RootCause.find(params[:id])
    root_cause.destroy
    flash[:notice] = "Root Cause has been successfully deleted"
    redirect_to root_causes_path()
  end

  def index
    @tab = TabConstants::ROOT_CAUSES
    @root_causes = RootCause.order("root_cause_bugs_count DESC").page(params[:page])
  end

  def show
    @tab = TabConstants::ROOT_CAUSES
    @root_cause = RootCause.find(params[:id])
		@bugs= @root_cause.bugs
		@followups= @root_cause.followups
  end

end
