require 'spec_helper'

describe User do

  describe 'abilities' do
    subject { Ability.new current_user }

    context 'with others user action' do
      let(:other_user) { create :user, email: 'other_user@user.com' }
      let(:user_action) { create :user_action, user: other_user }
      context 'when regular user' do
        let(:current_user) { create :user }
        it { should_not be_able_to(:show, user_action) }
      end

      context 'when admin user' do
        let(:current_user) { create :administrator }
        it { should be_able_to(:show, user_action) }
      end
    end

    context 'with own action' do
      let(:current_user) { create :user }
      let(:user_action) { create :user_action, user: current_user }
      it { should be_able_to(:show, user_action) }
    end
  end

  describe '#active_for_authentication?' do

    describe 'when user is not disabled' do
      subject { create :user }

      it 'returns true' do
        subject.active_for_authentication?.should be_truthy
      end
    end

    describe 'when user is disabled' do
      subject { create :user, disabled: true }

      it 'returns false' do
        subject.active_for_authentication?.should be_falsey
      end
    end
  end

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
          it 'should save and return roles' do
            admin_role = Role.find_by_name('administrator')

            @user.roles << admin_role

            @user = @user.reload

            @user.roles.should include admin_role
          end
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
