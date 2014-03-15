When(/^I log an action called '(.*)'$/) do |action_name|
  page.should have_link 'Achieve!'
  click_link 'Achieve!'
  page.should have_content 'What did you do?'
  fill_in 'What did you do?', with: action_name
  click_button 'Save'
end


And(/^I log the following actions$/) do |table|
  # table is a table.hashes.keys # => [:name]
  table.hashes.each do |row|
    step "I log an action called '#{row[:name]}'"
  end

end