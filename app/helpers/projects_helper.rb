module ProjectsHelper
  # method for displaying currency
  def format_currency(value)
    number_to_currency(value/100, delimiter: ",", separator: ".")
  end

  def proj_progress(total, goal)
    @result = total / goal.to_f * 100
  end

  def days_to_go(date)
    if date > Date.current
      @day_left = (date - Date.current).to_i
    else
      @day_left = 0
    end
    pp @day_left
    return @day_left
  end

  def set_status(project)
    statuses = ["ongoing", "upcoming", "completed"]
    if project.start_date <= Date.current && project.due_date > Date.current
      project.status = true
      return @status = statuses[0]
    elsif project.start_date > Date.current && project.due_date > Date.current
      project.status = false
      return @status = statuses[1]
    else
      project.status = false
      return @status = statuses[2]
    end
  end

  def set_pill(status)
    case status
    when "ongoing"
      return "success"
    when "upcoming"
      return "primary"
    when "completed"
      return "secondary"
    end
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
