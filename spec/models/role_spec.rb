require 'spec_helper'

describe Role do
    before do
        @role = Role.new(name: 'fakeRole')
        @role.save!
    end

    subject { @role }

    it { should respond_to(:name) }
    it { should validate_uniqueness_of :name }
    it { should validate_presence_of :name }
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
