require 'spec_helper'

describe UserSessionsController do
  describe 'POST #create' do

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
    end

    describe 'when logging in as superuser' do
      describe 'when alternative superuser has been already been configured' do
        before do
          alt_super = create :user
          alt_super.roles << Role.find_by_name('superuser')
          post :create, user: {email: 'superuser@meritbadges.com', password: 'password'}
        end

        it { should redirect_to(root_path) }

        describe 'flash alert' do
          subject { flash[:alert] }
          it { should eq 'Default superuser is disabled.  Please login as a real person.' }
        end

        its(:current_user) { should be_nil }
      end

      describe 'when alternative superuser has NOT been already been configured' do
        before do
          post :create, user: {email: 'superuser@meritbadges.com', password: 'password'}
        end

        it { should redirect_to(root_path) }

        describe 'flash alert' do
          subject { flash[:alert] }
          it { should eq 'MeritBadges is not initialized.  Please configure another user as superuser.' }
        end

        its(:current_user) { should eq User.find_by_email('superuser@meritbadges.com') }
      end

    end

    describe 'when logging in as non-super user' do
      let(:current_user) { create :user, email: 'newguy@here.com' }

      describe 'when alternative superuser has been already been configured' do
        before do
          alt_super = create :user
          alt_super.roles << Role.find_by_name('superuser')
          post :create, user: {email: current_user.email, password: 'factory!'}
        end

        it { should redirect_to(root_path) }

        it 'should display no alerts' do
          flash[:alert].should be_nil
        end

        its(:current_user) { should eq current_user }

      end

      describe 'when alternative superuser has not been configured' do
        before do
          post :create, user: {email: current_user.email, password: 'factory!'}
        end

        it { should redirect_to(root_path) }

        describe 'flash alert' do
          subject { flash[:alert] }
          it { should eq 'MeritBadges is not initialized.  Please login as superuser and configure another user as superuser.' }
        end

        its(:current_user) { should be_nil }
      end
    end
  end
end
