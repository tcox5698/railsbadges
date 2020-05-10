FactoryBot.define do
  factory :user, class: User do
    email 'user@email.com'
    confirmed_at Time.now
    password 'factory!'
    password_confirmation 'factory!'

    transient do
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
      transient do
        user_roles  ['superuser']
      end
    end

    factory :administrator do
      transient do
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
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
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
