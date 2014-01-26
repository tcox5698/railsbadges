require 'spec_helper'

describe User do

    describe 'model' do
        before do
            @user = User.new(email: 'fake@faker.com', password: 'password8', password_confirmation: 'password8')
            @user.save!
        end

        subject { @user }

        it { should respond_to(:email) }
        it { should validate_uniqueness_of :email }
        it { should validate_presence_of :email }

        describe 'user roles' do
          it
        end
    end

    describe 'abilities' do
        let(:user) { User.new(id: 19, email: 'fake@fake.com', password: 'password', password_confirmation: 'password') }
        let(:user_role) { Role.new(name: 'user') }
        let(:administrator_role) { Role.new(name: 'administrator') }
        let(:superuser_role) { Role.new(name: 'superuser') }

        subject { Ability.new(user) }

        before do
            user.roles << roles
        end

        context 'when user has superuser role' do
            let(:roles) { [superuser_role] }

            it { should be_able_to(:create, User.new) }
            it { should be_able_to(:read, User.new) }
            it { should be_able_to(:update, User.new) }
            it { should_not be_able_to(:destroy, User.new) }
        end

        context 'when user has only user role' do
            let(:roles) { [user_role] }

            it { should_not be_able_to(:create, User.new) }
            it { should_not be_able_to(:destroy, User.new) }
            it { should_not be_able_to(:read, User.new) }
            it { should_not be_able_to(:update, User.new) }

            it { should be_able_to(:read, user) }
            it { should be_able_to(:update, user) }

            it { should_not be_able_to(:destroy, user) }
        end

        context 'when user has admin role' do
            let(:roles) { [administrator_role] }

            it { should be_able_to(:create, User.new) }
            it { should be_able_to(:read, User.new) }
            it { should be_able_to(:update, User.new) }

            it { should_not be_able_to(:destroy, User.new) }

            it { should be_able_to(:read, user) }
            it { should be_able_to(:update, user) }

            it { should_not be_able_to(:destroy, user) }
        end
    end
end
