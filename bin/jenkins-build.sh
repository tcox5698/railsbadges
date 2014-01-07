set -e

rvm use 2.1.0

bundle install

bundle exec rake db:drop db:create
bundle exec rake db:migrate
bundle exec rake db:test:prepare
xvfb-run bundle exec rake
