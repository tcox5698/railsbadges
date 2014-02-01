require 'spec_helper'

describe UserSessionsController do
  describe 'POST #create' do
    describe 'when logging in as normal user' do
      let(:current_user) { create :user, email: 'newguy@here.com' }

      before do
        @request.env["devise.mapping"] = Devise.mappings[:user]
      end

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

      end

      describe 'when alternative superuser has not been configured' do
        before do
          post :create, user: {email: current_user.email, password: 'factory!'}
        end

        it { should redirect_to(root_path) }

        it 'should display no alerts' do
          flash[:alert].should be_nil
        end
      end
    end
  end
end
