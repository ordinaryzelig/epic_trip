require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] = "test"
  require File.expand_path('../../config/environment', __FILE__)

  require 'minitest/autorun'
  require 'minitest/pride'
  require 'capybara/rails'

  # Require support files.
  Dir['./test/support/**/*.rb'].each { |f| require f }

  DatabaseCleaner.strategy = :truncation

  class MiniTest::Spec
    before do
      DatabaseCleaner.clean
    end
  end

  # Create MiniTest::Spec subclass for integration tests.
  class IntegrationSpec < MiniTest::Spec
    include Rails.application.routes.url_helpers
    include Capybara::DSL
    include IntegrationMacros
    register_spec_type /integration$/i, self
  end

end

Spork.each_run do

end
