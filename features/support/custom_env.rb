require 'capybara/email'

World(Capybara::Email::DSL)


Capybara.register_driver :selenium_chrome do |app|
  #noinspection RubyArgCount
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.javascript_driver = :selenium_chrome

begin
    DatabaseCleaner.strategy = :truncation, {:except => %w[roles]}
rescue NameError
    raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

load "#{Rails.root}/db/seeds.rb"

Before do | scenario |
  unless User.exists? email: 'superuser@meritbadges.com'
    superuser = User.create email: 'superuser@meritbadges.com', confirmed_at: Time.now, password: 'password', password_confirmation: 'password'

    superuser.roles << Role.find_by_name('superuser')
  end
end

World(FactoryGirl::Syntax::Methods)