require 'spec_helper'


describe UserAction do
  subject { UserAction.new }
  it { should validate_presence_of :name }
  it { should validate_presence_of :action_date }
  it { should validate_presence_of :user_id }
end
