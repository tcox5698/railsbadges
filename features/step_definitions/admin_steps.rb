Then(/^I can view a list of users containing the following users$/) do |table|
  # table is a table.hashes.keys # => [:email, :roles]
  click_link 'Users'

  title = page.find 'main div.container h1'

  title.text.should eq 'Users'

  user_map = Hash[table.hashes.map { |user| [user[:email], user] }]

  html_rows = page.all 'table tr'

  html_rows.length.should eq table.hashes.length + 1

  html_rows.each_with_index do |row, index|
    if index > 0
      email_cell = row.find 'td:nth-of-type(1)'
      roles_cell = row.find 'td:nth-of-type(2)'

      expected_user = user_map[email_cell.text.strip]

      expected_user[:roles].split(',').each do |expected_role|
        roles_cell.should have_content expected_role.strip
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

Then(/^I disable user '(.*)'$/) do |email|
  edit_user email

end