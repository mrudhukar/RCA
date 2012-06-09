
class ReportsController < ApplicationController

  def bug_report
    @tab = TabConstants::MEETINGS
    data = current_team.bugs.order("created_at ASC").collect{|b| [b.created_at.strftime("%b %Y"), 1]}.group_by{|e| e[0]}
    #@data_array = data.group_by{|e| e[0]}.map{|k, v| [k, v.length]}
    
    start_month = Date.new(Time.now.year, Time.now.month, 3) - 2.year

    @dates = []
    (0..24).each do |index|
      @dates <<  (start_month + index.months).strftime("%b %Y")
    end
    @values = @dates.collect{|str| data.key?(str) ? data[str].size : 0}
  end

  def followups_report
    @tab = TabConstants::MEETINGS

    users = User.all(:include => :followups)
    @x_axis = users.collect(&:name)

    @finished_counts = []
    @not_started_counts = []
    @on_going_counts = []

    users.each do |u|
      all_f = u.followups
      f_hash = all_f.group_by(&:status)

      @finished_counts << (f_hash[Followup::Status::COMPLETED].try(:size) || 0)
      @not_started_counts << (f_hash[Followup::Status::NOT_STARTED].try(:size) || 0)
      @on_going_counts << (all_f.size - (f_hash[Followup::Status::COMPLETED].try(:size) || 0) - (f_hash[Followup::Status::NOT_STARTED].try(:size) || 0))
    end
  end
end
