require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
# require "action_cable/engine"
require 'sprockets/railtie'
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Thinknetica
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Setup I18n
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:en, :ru]
    config.i18n.enforce_available_locales = true
    # config.i18n.fallbacks = true

    config.time_zone = 'Moscow'

    config.generators do |g|
      g.assets          false
      g.helper          false
      g.stylesheets     false
      g.javascripts     false

      g.template_engine :haml

      g.orm             :active_record

      g.test_framework  :rspec,
                        fixtures: true,
                        view_specs: false,
                        helper_specs: false,
                        routing_specs: false,
                        request_specs: false,
                        controller_specs: true

      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
