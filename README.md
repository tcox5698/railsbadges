# railsbadges


Rails project for keeping up to date - tracks achievements!

## Local Development

1. install Ruby 2.1.10 `rvm install 2.1.10`
1. install bundler `gem install bundler`
1. install v8 `brew install v8`
1. `bundle install`
1. start postgres `./script/bootstrap_db.sh`
1. `rake db:create`
1. `rake db:migrate`
1. `rake db:migrate RAILS_ENV=test`
1. Run tests `rake spec`
1. Run the cucumber features `cucumber`
1. Start the app `rails s` 

## Initialization

On installation the app will create a default superuser. You must create a new user and 
give it the super user role before the app will function. 

Login as "superuser@meritbadges.com" with "password" and create a new user. When you
give the new user the role of superuser, the default superuser account will be disabled.


