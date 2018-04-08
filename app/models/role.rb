class Role < ApplicationRecord
    has_and_belongs_to_many :users

    validates :name, uniqueness: true, presence: true
end

# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#
