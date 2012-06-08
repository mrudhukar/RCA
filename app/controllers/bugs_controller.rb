class BugsController < ApplicationController
  def update
    team = current_team
    bug = team.bugs.find(params[:id])
    bug.update_attributes!(:ignored => true)
    flash[:notice] = "The bug has been ignored"
    redirect_to root_path()
  end
end
