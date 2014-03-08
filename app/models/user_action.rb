class UserAction < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :action_date, presence: true
  validates :name, presence: true
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
