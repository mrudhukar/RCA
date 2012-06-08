class BugsController < ApplicationController

  def index
    @tab = TabConstants::ARCHIVE
    @bugs = current_team.bugs.order("created_at DESC")
    
  end

  def update
    team = current_team
    bug = team.bugs.find(params[:id])
    bug.update_attributes!(:ignored => (params[:ignore] == "true"))
    flash[:notice] = "The bug has been ignored"
    redirect_to request.referer
  end

end
