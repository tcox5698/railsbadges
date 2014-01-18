require 'spec_helper'

describe UsersController do

  let!(:other_user) { create :user, email: 'other@factory.com' }

  describe 'authorizations' do
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
