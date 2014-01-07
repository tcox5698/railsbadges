Given(/^I have not logged in$/) do
end

When(/^I visit the application$/) do
    visit '/'
end

Then(/^I see the text '(.*)'$/) do |expected_text|
    page.should have_content expected_text
end