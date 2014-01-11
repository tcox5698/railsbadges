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
    fill_in 'Email', :with => username
    fill_in 'Password', :with => password
    fill_in 'Password confirmation', :with => password
    click_button 'Sign up'
    page.should have_content 'A message with a confirmation link has been sent to your email address. Please open the link to activate your account.'
end

Then(/^I receive an email confirmation$/) do
    confirmation = ActionMailer::Base.deliveries.last

    confirmation.body.should have_content 'You can confirm your account email through the link below'
end

When(/^I follow the link in the email confirmation$/) do
    confirmation = ActionMailer::Base.deliveries.last
    visit confirmation.click_link 'Confirm my account'
end

Then(/^I can login with username '(.*)' and password '(.*)'$/) do |arg1|
    pending # express the regexp above with the code you wish you had
end