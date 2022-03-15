module ProjectsHelper
  def format_currency(value)
    number_to_currency(value/100, delimiter: ",", separator: ".")
  end

  def proj_progress(total, goal)
    @result = total / goal.to_f * 100
  end

  def days_to_go(start, due)
    @day_left = (start - due).to_i
  end

  # generate image link for accessing images in AWS S3 bucket 
  # or local active storage depending on the environment
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
