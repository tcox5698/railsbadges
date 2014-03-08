When(/^I visit the dashboard$/) do
  click_link 'Dashboard'
end

Then(/^I see the dashboard$/) do
  page.find('#dashboard_container').should have_content 'Dashboard'
end

Then(/^I see '(.*)' in my recent actions$/) do |expected_text|
  page.should have_content expected_text
end