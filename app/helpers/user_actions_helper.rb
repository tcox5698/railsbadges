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

module UserActionsHelper
end
