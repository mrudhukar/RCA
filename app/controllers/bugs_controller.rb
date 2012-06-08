class BugsController < ApplicationController

  def show
    @tab = TabConstants::ARCHIVE
    @bug = current_team.bugs.find(params[:id])
    @root_causes = @bug.root_causes
  end

  def index
    @tab = TabConstants::ARCHIVE
    @bugs = current_team.bugs.order("created_at DESC")
    
  end

  def update
    bug = current_team.bugs.find(params[:id])
    bug.update_attributes!(:ignored => (params[:ignore] == "true"))
    flash[:notice] = "The bug has been ignored"
    redirect_to request.referer
  end

end
