require 'capybara/email'

World(Capybara::Email::DSL)

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :selenium_chrome

begin
    DatabaseCleaner.strategy = :truncation
rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end