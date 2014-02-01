Given(/^email '(.*)' does not exist$/) do |username|
end

def visit_login
  visit '/users/sign_in'
end

When(/^I visit the login page$/) do
  visit_login
end

Then(/^I have the option to create a new account$/) do
  page.should have_link 'Sign up'
end

When(/^I create an account with email '(.*)' and password '(.*)'$/) do |username, password|
  click_link 'Sign up'
  page.should have_content 'Email'
  fill_in 'Email', :with => username
  fill_in 'Password', :with => password
  fill_in 'Password confirmation', :with => password
  click_button 'Sign up'
  page.should have_content 'A message with a confirmation link has been sent to your email address. Please open the link to activate your account.'
end

def get_last_email
  Capybara::Node::Email.new(Capybara.current_session, Capybara::Email::Driver.new(ActionMailer::Base.deliveries.last))
end

Then(/^I receive an email confirmation at '(.*)'$/) do |email_address|
  confirmation = get_last_email()

  confirmation.should have_content 'You can confirm your account email through the link below'
end

When(/^I follow the link in the email confirmation sent to '(.*)'$/) do |email_address|
  confirmation = get_last_email()

  confirmation.click_link 'Confirm my account'

  page.should have_content 'Your account was successfully confirmed.'
  page.should have_content 'Sign in'
end

def login(username, password)
  fill_in 'Email', :with => username
  fill_in 'Password', :with => password

  page.click_button 'Sign in'
end

Then(/^I can login with email '(.*)' and password '(.*)'$/) do |email, password|
  login(email, password)
  page.should have_content email.partition('@').first
end

When(/^I login as a normal user$/) do
  email = 'fake@fake.com'
  password = 'password'
  user = User.new(email: email, password: password,
                  password_confirmation: password, confirmed_at: Time.now).save!

  puts user

  visit_login
  login email, password
end

Then(/^the application tells me '(.*)'$/) do |expected_message|
  page.should have_content expected_message
end

When(/^I logout$/) do
  click_link 'Logout'
end

Then(/^the '(.*)' link is not visible$/) do |link_text|
  page.should_not have_content link_text
end

Then(/^the '(.*)' link is visible$/) do |link_text|
  page.should have_content link_text
end

Given(/^I am not logged in$/) do
  visit '/'
  if page.has_content? 'Logout'
    click_link 'Logout'
  end
  page.should have_content 'Login'

end

Then(/^I am prompted to login$/) do
  page.find :xpath, '//h2[text()="Sign in"]'
end

Given(/^no one has logged in as superuser$/) do
  Role.find_by_name('superuser').users.count.should eq 1
end

And(/^I should not be logged in$/) do
  visit '/'
  page.should have_link 'Login'
end

When(/^I log in as superuser$/) do
  visit_login
  login 'superuser@meritbadges.com', 'password'
  page.should have_content 'Signed in successfully.'
end

Then(/^I am prompted to configure a user with administrator role$/) do
  page.should have_content 'MeritBadges is not initialized. Please configure another user as superuser.'
end

Given(/^the following users exist$/) do |table|
  # table is a table.hashes.keys # => [:email, :roles, :password]
  table.hashes.each do |row_hash|
    user = User.create email: row_hash[:email],
                       password: row_hash[:password],
                       password_confirmation: row_hash[:password],
                       confirmed_at: Time.now

    roles = row_hash[:roles].split ','
    roles.each do |role|
      user.roles << Role.find_by_name(role.strip)
    end
  end
end

When(/^I login as '(.*)' with password '(.*)'$/) do |email, password|
  visit_login
  login email, password
  page.should have_content 'Signed in successfully.'
end