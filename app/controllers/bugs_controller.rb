class BugsController < ApplicationController

  def show
    @tab = TabConstants::ARCHIVE
    @bug = current_team.bugs.find(params[:id])
  end

  def index
    @tab = TabConstants::ARCHIVE
    @bugs = current_team.bugs.order("created_at DESC")
    
  end

  def update
    bug = current_team.bugs.find(params[:id])
    if params[:rca] == "true"

    elsif params[:ignore].present?
      ignored = (params[:ignore] == "true")
      bug.update_attributes!(:ignored => ignored)
      flash[:notice] = "The bug has been #{ignored ? 'ignored' : 'included'}"
      redirect_to request.referer
    elsif params[:mark_done].present?
      mark_done = (params[:mark_done] == "true")
      if mark_done
        if bug.root_causes.size > 0
          bug.update_attributes!(:conducted_at => Date.today)
          flash[:notice] = "RCA has been marked done"
        else
          flash[:error] = "RCA cannot be marked done as there are not root causes added"
        end
      else
        bug.update_attributes!(:conducted_at => nil)
        flash[:notice] = "RCA has been marked undone"
      end
      redirect_to request.referer
    end
    
  end

  def new_rca
    @tab = TabConstants::ARCHIVE
    @bug = current_team.bugs.find(params[:id])
  end

end
