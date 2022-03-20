class ApplicationController < ActionController::Base
  # when clicking back in browser on payment page
  # /payments?id= should be POST method, but sometimes it behaves GET
  # it causes routing error occurs 
  def route_not_found
    render file: Rails.public_path.join('404.html'), status: :not_found, layout: true
  end
end
