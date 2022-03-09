module ApplicationHelper

  def format_text(text)
    text.capitalize
  end

  def select_alert_subclass(input)
    case input
    when 'notice'
      return 'success'
    when 'alert'
      return 'warning'
    when 'error'
      return 'danger'
    else
      return 'info'
    end
  end
end
