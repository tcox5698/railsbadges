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
      user = user.reload

      evaluator.user_roles.each do |role|
        the_role = Role.find_by_name(role)
        the_role.users<<user
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

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  disabled               :boolean
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
