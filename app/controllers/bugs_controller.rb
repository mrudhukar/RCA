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
      bug.update_attributes!(:conducted_at => mark_done ? Date.today : nil)
      flash[:notice] = "RCA has been marked #{mark_done ? 'done' : 'undone'}"
      redirect_to request.referer
    end
    
  end

  def new_rca
    @tab = TabConstants::ARCHIVE
    @bug = current_team.bugs.find(params[:id])
  end

end
