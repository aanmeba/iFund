module ProjectsHelper
  def format_price(price)
    "$#{(price/100.0)}"
  end

  def format_text(text)
    text.capitalize
  end
end
