module ProjectsHelper
  def format_price(price)
    "$#{(price/100)}"
  end

  def number_to_currency(number, options = {})
    delegate_number_helper_method(:number_to_currency, number, options)
  end

  def image_link(temp)
    @base_url = "https://ja-ifund-rails-app.s3.ap-southeast-2.amazonaws.com/"
    @location = "default/default_"
    @key = @categories.find(temp.category_id).name
    @extension = ".jpeg"
    
    begin
      if Rails.env.development?
        @location + @key + @extension
      elsif Rails.env.staging? || Rails.env.production?
        @base_url + @location + @key + @extension
      end  
    rescue => exception
      "#"
    end

  end
end
