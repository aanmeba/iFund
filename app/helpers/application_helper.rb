module ApplicationHelper

  # Use it in projects and options controllers
  def format_text(text)
    if text.include?(" ")
      text.split(" ").map {|word| word.capitalize}.join(" ")
    elsif text.include?("_")
      text.split("_").map {|word| word.capitalize}.join(" ")
    else
      text.capitalize
    end
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
