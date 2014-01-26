require 'spec_helper'

describe UsersController do


  describe '#edit' do
    let(:input_user_id) { '73' }
    let(:current_user) { stub_model User, email: 'current@user.stub' }
    let(:stub_ability) { double "Ability" }
    let(:edit_user) { stub_model User }
    let(:expected_roles) { [Role.new(name: 'fakeRole1')] }

    before do
      Ability.should_receive(:new).and_return stub_ability
      stub_ability.stub(:authorize!).and_return true
      sign_in current_user
      User.should_receive(:find).with(input_user_id).and_return edit_user
      Role.should_receive(:all).and_return expected_roles

      get :edit, id: input_user_id
    end

    context 'when user has ability to manage users' do
      describe 'the edited user' do
        subject { assigns :user }

        it { should eq edit_user }
      end

      describe 'the available roles' do
        subject { assigns :available_roles }

        it { should eq expected_roles}
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
