require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module IFund
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.autoload_paths += %W(#{Rails.root}/app/models/users)

    # add support for custom environments in heroku
    if ENV['PIPE_ENV'].present?
      env_name = Rails.root.join("config/credentials/#{ENV['PIPE_ENV']}")
      Rails.application.config.credentials.content_path = "#{env_name}.yml.enc"

      if File.exist? "#{env_name}.key"
        Rails.application.config.credentials.key_path = "#{env_name}.key"
      end
    end
  end
end
