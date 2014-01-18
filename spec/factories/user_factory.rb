FactoryGirl.define do
  factory :user, class: User do
    email 'user@email.com'
    confirmed_at Time.now
    password 'factory!'
    password_confirmation 'factory!'

    ignore do
      user_roles  ['user']
    end

    after(:create) do |user, evaluator|
      evaluator.user_roles.each do |role|
        user.roles << Role.find_by_name(role)
      end
    end

    factory :superuser do
      ignore do
        user_roles  ['superuser']
      end
    end

    factory :administrator do
      ignore do
        user_roles  ['administrator']
      end
    end
  end
end