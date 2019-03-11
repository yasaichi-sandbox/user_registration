require 'bundler/setup'
require 'hanami/setup'
require 'hanami/model'
require_relative '../lib/sample_app'
require_relative '../apps/web/application'

Hanami.configure do
  mount Web::Application, at: '/'

  model do
    ##
    # Database adapter
    #
    # Available options:
    #
    #  * SQL adapter
    #    adapter :sql, 'sqlite://db/sample_app_development.sqlite3'
    #    adapter :sql, 'postgresql://localhost/sample_app_development'
    #    adapter :sql, 'mysql://localhost/sample_app_development'
    #
    adapter :sql, ENV.fetch('DATABASE_URL')

    ##
    # Migrations
    #
    migrations 'db/migrations'
    schema     'db/schema.sql'
  end

  mailer do
    root 'lib/sample_app/mailers'
  end

  environment :development do
    # See: http://hanamirb.org/guides/projects/logging
    logger level: :debug

    mailer do
      delivery LetterOpener::DeliveryMethod, location: File.expand_path('../tmp/letter_opener', __dir__)
    end
  end

  environment :test do
    mailer do
      delivery :test
    end
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    end
  end
end
