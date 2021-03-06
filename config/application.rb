require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Udem
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    config.time_zone = 'Moscow'

    config.to_prepare do
      ActionText::ContentHelper.allowed_attributes.add 'style'
      ActionText::ContentHelper.allowed_attributes.add 'controls'
      ActionText::ContentHelper.allowed_tags.add 'video'
      ActionText::ContentHelper.allowed_tags.add 'audio'
      ActionText::ContentHelper.allowed_tags.add 'source'
      ActionText::ContentHelper.allowed_tags.add 'iframe'
    end

    Recaptcha.configure do |config|
      config.site_key = Rails.application.credentials.dig(:recaptcha, :site_key)
      config.secret_key = Rails.application.credentials.dig(:recaptcha, :secret_key)
    end
  end
end
