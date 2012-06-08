class RootCausesController < ApplicationController

  def new
    @bug = current_team.bugs.find(params[:bug_id])
    @root_cause = RootCause.new()
  end

  def create
    @root_cause = RootCause.create!(params[:root_cause].slice(*[:title, :description]))
    @bug = current_team.bugs.find(params[:bug_id])
    @root_cause.bugs << @bug
    flash[:notice] = "Root Cause has been successfull created"
    redirect_to team_bug_path(current_team, @bug)
  end

  def index
    @tab = TabConstants::ROOT_CAUSES
    @root_causes = RootCause.order("root_cause_bugs_count DESC").all

  end

  def show
    
  end

end
