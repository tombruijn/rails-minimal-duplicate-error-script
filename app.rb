# frozen_string_literal: true

require "bundler/inline"
gemfile(true) do
  source "https://rubygems.org"

  gem "rails", "8.0.0.1"
end

require "action_controller/railtie"
require "minitest/autorun"
require "rack/test"

class TestApp < Rails::Application
  config.load_defaults Rails::VERSION::STRING.to_f
  config.root = __dir__
  config.eager_load = false
  config.hosts << "example.org" << "localhost"
  config.secret_key_base = "secret_key_base"

  config.logger = Logger.new($stdout)

  # development: true
  # production: false
  config.consider_all_requests_local = ENV["RAILS_ENV"] != "production"
end
class MyErrorSubscriber
  def self.reported_errors
    @reported_errors ||= []
  end

  def self.report(error, handled:, severity:, context: {}, source: nil)
    puts "MyErrorSubscriber: #{error.class}: #{error}"
    reported_errors << error
  end
end
Rails.error.subscribe(MyErrorSubscriber)
Rails.application.initialize!

puts "Rails env: #{Rails.env}"

Rails.application.routes.draw do
  get "/", to: "test#index"
end

class TestController < ActionController::Base
  include Rails.application.routes.url_helpers
  prepend_view_path ''

  def index
    render :index
  end
end

class BugTest < ActiveSupport::TestCase
  include Rack::Test::Methods

  def test_returns_success
    get "/"

    errors = MyErrorSubscriber.reported_errors
    pp errors
    assert_equal errors.length, 1
    assert_equal errors.first.class, ActionView::Template::Error
  end

  private

  def app
    Rails.application
  end
end
