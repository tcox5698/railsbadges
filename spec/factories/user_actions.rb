# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_action do
    name "MyString"
    action_date "2014-02-09 19:16:56"
    user nil
  end
end
