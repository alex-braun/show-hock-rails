# frozen_string_literal: true
require File.expand_path('../boot', __FILE__)

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
# require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
# require 'action_mailer/railtie'
# require 'action_view/railtie'
# require 'sprockets/railtie'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShowHockApi
  # :nodoc:
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified
    # here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record
    # auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    # Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from
    # config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path +=
    #   Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
#     config.active_record.raise_in_transactional_callbacks = true
#
#     # Cross-Origin Resource Sharing
#     # development client port
#     cors_port = 'GA'.each_byte.reduce('') { |a, e| a + format('%d', e) }.to_i
#     config.middleware.insert_before 0, Rack::Cors do
#       allow do
#         origins do |origin, _env|
#           '*' == ENV['CLIENT_ORIGIN'] ||
#             origin == ENV['CLIENT_ORIGIN'] ||
#             origin == "http://localhost:#{cors_port}"
#         end
#         resource '*',
#                  headers: :any,
#                  methods: [:options, :get,
#                            :post, :patch, :put, :delete]
#       end
#     end
#   end
# end

config.active_record.raise_in_transactional_callbacks = true

    # Cross-Origin Resource Sharing
    # development client port
    cors_port = 'GA'.each_byte.reduce('') { |a, e| a + format('%d', e) }.to_i
    config.middleware.use Rack::Cors do
      allow do
        # origins ENV['CLIENT_ORIGIN'] || "http://localhost:#{cors_port}"
        origins ENV['CLIENT_ORIGIN'] || 'http://localhost:4200'
        resource '*',
                 headers: :any,
                 methods: [:options, :get,
                           :post, :patch, :put, :delete]
      end
    end
  end
end
