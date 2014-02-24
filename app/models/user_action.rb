class UserAction < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true
  validates :action_date, presence: true
  validates :name, presence: true
end
