require 'spec_helper'

describe UsersController do
  describe 'POST #update' do
    describe 'as the superuser' do
      let(:current_user) { User.find_by_email 'superuser@meritbadges.com' }
      let!(:edit_user) { create :user, email: 'editme@here.com', user_roles: ['user'] }

      describe 'when I update a user successfully' do
        before do
          sign_in current_user
          put :update, id: edit_user.id, user: {email: edit_user.email, disabled: true}, selected_roles: [Role.find_by_name('administrator').id]
        end

        its(:current_user) { should be_nil }
        it { should redirect_to root_path }

        describe 'flash alert' do
          subject { flash[:alert] }
          it { should eq 'Logged out superuser since you updated a user. Login as a real person now.' }
        end

        describe 'the updated user' do
          subject { assigns :user }

          its(:disabled) { should be_true }
          its(:roles) { should include Role.find_by_name('administrator') }

        end
      end
    end
  end

  describe 'GET #edit' do
    let!(:normal_user) {create :user, email: 'normal@user.com'}
    let!(:administrator) {create :administrator}
    let!(:edit_user) { create :user, email: 'edit@user.com' }
    let(:input_user_id) { edit_user.id }

    before do
      sign_in current_user

      get :edit, id: input_user_id
    end

    context 'when user does not have ability to edit users' do
      let(:current_user) { normal_user }

      describe 'the response' do
        subject { response }

        it { should be_redirect }
      end
    end

    context 'when user has ability to manage users' do
      let(:current_user) { administrator }

      describe 'the edited user' do
        subject { assigns :user }

        it { should eq edit_user }
      end

      describe 'the available roles' do
        subject { assigns :available_roles }

        it { should eq Role.all }
      end

    end
  end

  describe 'authorizations' do
    let!(:other_user) { create :user, email: 'other@factory.com' }

    before do
      sign_in user
    end

    describe 'GET index' do
      before do
        get :index
      end

      subject { (assigns :users).to_a }

      context 'superuser' do
        let!(:user) { create :superuser }
        let(:expected_users) { [other_user, user] }

        its(:length) { should eq 3 }
        it { should eq User.all.to_a }
      end

      context 'administrator' do
        let!(:user) { create :administrator }
        let(:expected_users) { [other_user, user] }

        its(:length) { should eq 3 }
        it { should eq User.all.to_a }
      end

      context 'user' do
        let!(:user) { create :user }
        let(:expected_users) { [user] }
        its(:length) { should eq 1 }
        it { should eq expected_users }
      end
    end
  end
end
