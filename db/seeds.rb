# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


['user', 'administrator', 'superuser'].each do |role_name|
    Role.new(name: role_name).save! unless Role.exists?(:name => role_name)
end

unless User.exists?(:email => 'superuser@meritbadges.com')
    superuser = User.new(email: 'superuser@meritbadges.com', password: 'password', password_confirmation: 'password', confirmed_at: Time.now)
    superuser.roles << Role.find_by_name('superuser')
    superuser.save!
end