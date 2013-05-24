module ApplicationHelper
  def flash_messages
    flash_messages = []
    flash.each do |type, message|
      # Skip Devise :timeout flag
      type = case type
                  when :timeout then next
                  when :notice then :success
                  when :alert then :error
                  end
      flash_messages << bootstrap_alert(message, type) if message
    end
    flash_messages.join("\n").html_safe
  end

  def bootstrap_alert(message, type)
    content_tag :div, message, :class => "alert fade in alert-#{type}"
  end
end
