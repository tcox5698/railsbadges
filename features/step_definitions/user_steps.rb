Given(/^username '(.*)' does not exist$/) do | username |
end

When(/^I try to login$/) do
    visit '/users/sign_in'
end

Then(/^I have the option to create a new account$/) do
    page.should have_link 'Sign up'
end

When(/^I create an account with username '(.*)' and password '(.*)'$/) do |username, password|
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

Then(/^I can login with username '(.*)' and password '(.*)'$/) do |username, password|

    fill_in 'Email', :with => username
    fill_in 'Password', :with => password

    page.click_button 'Sign in'

    page.should have_content 'Signed in successfully'
end

Given(/^I am logged in$/) do
    user = User.new
end

Then(/^the application tells me I am already logged in$/) do
    pending # express the regexp above with the code you wish you had
end

When(/^I logout$/) do
    pending # express the regexp above with the code you wish you had
end

Then(/^I see the login page$/) do
    pending # express the regexp above with the code you wish you had
end