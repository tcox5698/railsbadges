When(/^I log an action called '(.*)'$/) do |action_name|
  page.should have_link 'Achieve!'
  click_link 'Achieve!'
  page.should have_content 'What did you do?'
  fill_in 'What did you do?', with: action_name
  click_button 'Save'
end