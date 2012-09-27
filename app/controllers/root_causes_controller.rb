class RootCausesController < ApplicationController

  def new
    @bug = current_team.bugs.find(params[:bug_id])
    @root_cause = current_team.root_causes.new()
  end

  def create
    @root_cause = nil
    if !params[:root_cause_id].blank?
      @root_cause = current_team.root_causes.find_by_id(params[:root_cause_id])
    else
      @root_cause = current_team.root_causes.create!(params[:root_cause].slice(*[:title, :description]))
    end
    
    @bug = current_team.bugs.find(params[:bug_id])
    @root_cause.bugs << @bug
  end

  def edit
    @root_cause = current_team.root_causes.find(params[:id])
  end

  def update
    root_cause = current_team.root_causes.find(params[:id])
    root_cause.update_attributes!(params[:root_cause].slice(*[:title, :description]))
    flash[:notice] = "Root Cause has been successfully updated"
    redirect_to root_cause_path(root_cause)
  end

  def destroy
    root_cause = current_team.root_causes.find(params[:id])
    root_cause.destroy
    flash[:notice] = "Root Cause has been successfully deleted"
    redirect_to root_causes_path()
  end

  def index
    @tab = TabConstants::ROOT_CAUSES
    @root_causes = current_team.root_causes.order("root_cause_bugs_count DESC").page(params[:page]).per(10)
  end

  def show
    @tab = TabConstants::ROOT_CAUSES
    @root_cause = current_team.root_causes.find(params[:id])
		@bugs= @root_cause.bugs
		@followups= @root_cause.followups
  end

  def suggest
    bug = current_team.bugs.find_by_id(params[:bug_id])
    exclude_root_causes = bug.present? ? bug.root_causes.collect(&:id) : []
    @suggestions = RootCause.suggestions(params[:title_query], current_team.root_causes.collect(&:id) - exclude_root_causes)
  end
end
