When(/^I visit the dashboard$/) do
  click_link 'Dashboard'
end

Then(/^I see the dashboard$/) do
  page.find('#dashboard_container').should have_content 'Dashboard'
end

Then(/^I see '(.*)' in my recent actions$/) do |expected_text|
  page.should have_content expected_text
end

Then(/^I should see these and only these actions in this order$/) do |table|
  action_elements = page.all :css, 'p.action_list_item'
  action_elements.length.should eq table.rows.length

  action_elements.each_with_index do |element, index|
    element.text.should eq table.hashes[index][:name]
  end
end