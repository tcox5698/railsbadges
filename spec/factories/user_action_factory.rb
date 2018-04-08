FactoryBot.define do
  factory :user_action do
    name "factory_action"
    action_date "2014-02-09 19:16:56"
    association :user, {factory: :user, email: "action_user@action.com"}
  end
end

# == Schema Information
#
# Table name: user_actions
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  action_date :datetime
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_user_actions_on_user_id  (user_id)
#
