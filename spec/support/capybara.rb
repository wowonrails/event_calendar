require "capybara/rspec"
require "capybara-screenshot/rspec"
require "capybara/poltergeist"

Capybara.configure do |config|
  config.match = :prefer_exact
  config.javascript_driver = :poltergeist
  config.asset_host = "http://#{ENV.fetch('HOST')}"
end

Capybara::Screenshot.autosave_on_failure = false

Capybara.register_driver :poltergeist do |app|
  options = {
    js_errors: true,
    inspector: true
  }
  Capybara::Poltergeist::Driver.new(app, options)
end
