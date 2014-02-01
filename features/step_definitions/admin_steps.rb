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
  click_link 'Users'
  page.find :xpath, "//h1='Users'"
  tr = page.find :xpath, "//tr[td='#{email}']"
  tr.find(:xpath, "td/a='Edit'").click
end