When(/^I visit the dashboard$/) do
    visit '/'
    click_link 'Dashboard'
end

Then(/^I see the dashboard$/) do
    page.find('#dashboard_container').should have_content 'Dashboard'
end