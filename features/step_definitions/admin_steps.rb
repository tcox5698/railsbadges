Then(/^I can view a list of users containing the following users$/) do |table|
  # table is a table.hashes.keys # => [:email, :roles]
  click_link 'Users'

  title = page.find 'main div.container h1'

  title.text.should eq 'Users'

  table.hashes.each do | user |
    pending
  end
end