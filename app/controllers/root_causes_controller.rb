class RootCausesController < ApplicationController

  def index
    @tab = TabConstants::ROOT_CAUSES
    @root_causes = RootCause.order("root_cause_bugs_count DESC").all

  end

  def show
    
  end

end
