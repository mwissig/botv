require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Borona
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end

Raven.configure do |config|
  config.dsn = 'https://12a2d39b955948beb99e240bb3b758ac:a2b9a133798d46e9bf059bf53952b31b@o225165.ingest.sentry.io/5199199'
end

VideoInfo.provider_api_keys = { youtube: ENV['youtube_key'], vimeo: ENV['vimeo_key'] }
