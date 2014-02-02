Then(/^I can view a list of users containing the following users$/) do |table|
  # table is a table.hashes.keys # => [:email, :roles]
  click_link 'Users'

  page.should have_xpath '//main/div/h1[text()="Users"]'

  user_map = Hash[table.hashes.map { |user| [user[:email], user] }]

  html_rows = page.all 'table tr'

  html_rows.length.should eq table.hashes.length + 1

  html_rows.each_with_index do |row, index|
    if index > 0
      email_cell = row.find 'td:nth-of-type(1)'
      roles_cell = row.find 'td:nth-of-type(2)'

      expected_user = user_map[email_cell.text.strip]

      all_role_names = Role.all.collect { |role| role.name }
      expected_role_names = expected_user[:roles].split(',').collect{|s|s.strip}
      actual_role_names = roles_cell.text.split(',').collect{|s|s.strip}

      all_role_names.each do |role_name|
        actual_role_names.should include role_name.strip if expected_role_names.include? role_name
        actual_role_names.should_not include role_name.strip if !expected_role_names.include? role_name
      end
    end
  end
end

When(/^I give user '(.*)' the role of '(.*)'$/) do |email, role|
  edit_user email
  page.select role, :from => 'selected_roles[]'
  click_button 'Update User'
end

When(/^I visit '(.*)'$/) do |path|
  visit path
end

def edit_user(email)
  click_link 'Users'
  tr = page.find :xpath, "//tr[td[text()='#{email}']]"
  tr.find(:xpath, "td/a[text()='Edit']").click
  page.should have_content 'Editing user'
end

Then(/^I (enable|disable) user '(.*)'$/) do |enable_flag, email|
  edit_user email
  if enable_flag == 'enable'
    page.find('input[name="user[disabled]"][type="checkbox"]').checked?.should be_true
    uncheck 'Disabled'
  else
    page.find('input[name="user[disabled]"][type="checkbox"]').checked?.should be_false
    check 'Disabled'
  end
  click_button 'Update User'
  page.should have_content 'User was successfully updated.'
end