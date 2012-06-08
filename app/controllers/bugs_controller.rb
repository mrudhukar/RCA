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
    @bug = current_team.bugs.find(params[:id])
    if params[:rca] == "true"

    elsif params[:ignore].present?
      handle_ignore_status
    elsif params[:mark_done].present?
      handle_rca_mark_done
    end
  end

  def add_rca
    @bug = current_team.bugs.find(params[:id])
    @root_causes = @bug.root_causes
  end

  private

  def handle_ignore_status
    ignored = (params[:ignore] == "true")
    @bug.update_attributes!(:ignored => ignored)
    flash[:notice] = "The bug has been #{ignored ? 'ignored' : 'included'}"
    redirect_to request.referer
  end

  def handle_rca_mark_done
    mark_done = (params[:mark_done] == "true")
    if mark_done
      if @bug.root_causes.size > 0
        @bug.update_attributes!(:conducted_at => Date.today)
        flash[:notice] = "RCA has been marked done"
      else
        flash[:error] = "RCA cannot be marked done as there are no root causes added"
      end
    else
      @bug.update_attributes!(:conducted_at => nil)
      flash[:notice] = "RCA has been marked undone"
    end
    redirect_to request.referer
  end

end
