require 'spec_helper'

describe User do
    before do
        @user = User.new(email: 'fake@faker.com', password: 'password8', password_confirmation: 'password8')
        @user.save!
    end

    subject { @user }

    it { should respond_to(:email) }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :email }
end
