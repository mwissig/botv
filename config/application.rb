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
  config.dsn = 'https://9134665251094f6b89bfa6983c7b6913:b8c2bdc12f7e4474bc40d1389c116493@sentry.io/5166663'
end

VideoInfo.provider_api_keys = { youtube: ENV['youtube_key'], vimeo: ENV['vimeo_key'] }
