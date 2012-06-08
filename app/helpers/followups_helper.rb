module FollowupsHelper
  def followup_status(status)
    case status
    when Followup::Status::NOT_STARTED
      content_tag(:span, "Not started", :class => "label label-important")
    when Followup::Status::SCHEDULED
      content_tag(:span, "Scheduled", :class => "label label-warning")
    when Followup::Status::STARTED
      content_tag(:span, "Started", :class => "label label-info")
    when Followup::Status::COMPLETED
      content_tag(:span, "Completed", :class => "label label-success")
    end
  end

  def followup_hash
    [
      ["Not Started", Followup::Status::NOT_STARTED],
      ["Scheduled", Followup::Status::SCHEDULED],
      ["Started", Followup::Status::STARTED],
      ["Completed", Followup::Status::COMPLETED]
    ]
  end
end
