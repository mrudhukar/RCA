module ApplicationHelper
  FLASHMAP = {
    :notice => "success",
    :error => "error",
    :alert => "warning"
  }

  def render_flash
    message = flash[:notice] || flash[:error] || flash[:alert]
    key = FLASHMAP[flash.keys[0]]
    if message
      content_tag(:div, :class => "alert alert-#{key}") do
        link_to("x", "#", :class => "close", :data => {:dismiss => "alert"}) + message
      end
    end
  end
end
