require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Shoppecookies
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.active_job.queue_adapter = :sidekiq

    config.i18n.default_locale = :es

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    #Auto-loading lib files in
    config.autoload_paths << Rails.root.join('lib')
    #add webfonts
    config.assets.paths << Rails.root.join("app", "assets", "fonts")

    config.eager_load_paths << Rails.root.join("lib","api")

    config.action_mailer.smtp_settings = {
        :address              => "smtp.gmail.com",
        :port                 => 587,
        :domain               => "gmail.com",
        :user_name            => ENV["SOULCOOKIES_EMAIL_U"],
        :password             => ENV["SOULCOOKIES_EMAIL_P"],
        :authentication       => :plain,
        :enable_starttls_auto => true
    }

    config.action_dispatch.default_headers = {
        'Access-Control-Allow-Origin' => '*',
        'Access-Control-Request-Method' => 'GET, PATCH, PUT, POST, OPTIONS, DELETE',
        'Access-Control-Allow-Headers:' => 'Origin, X-Requested-With, Content-Type, Accept'
    }
  end
end
