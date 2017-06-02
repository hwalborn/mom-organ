require_relative 'boot'

require 'httparty'
require 'rspotify'
require 'csv'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
# RSpotify::authenticate(Rails.application.secrets.client_id, Rails.application.secrets.client_secret)

module MomOrgan
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
