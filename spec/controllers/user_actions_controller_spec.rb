# == Schema Information
#
# Table name: user_actions
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  action_date :datetime
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_user_actions_on_user_id  (user_id)
#

require 'spec_helper'

describe UserActionsController do
  let(:valid_attributes) { {name: 'test action', action_date: Time.new} }
  let!(:admin_user) { create :administrator, email: 'admin@admin.com' }

  describe "GET index" do
    let(:expected_action) { create :user_action }

    before do
      sign_in current_user
      get :index, {}
    end

    describe 'the returned actions' do
      subject { assigns :user_actions }
      describe 'when actions exist for multiple users' do

        let!(:user) { create :user, email: 'user@user.com' }
        let!(:user_action) { create :user_action, user: user }
        let!(:admin_action) { create :user_action, user: admin_user }

        describe 'when administrator' do
          let(:current_user) { admin_user }
          it 'includes all the actions' do
            expect(subject).to eq [user_action, admin_action]
          end
        end

        describe 'when user' do
          let(:current_user) { user }
          it 'includes only the users actions' do
            expect(subject).to eq [user_action]
          end
        end
      end
    end
  end

  describe "GET show" do
    context 'when action belongs to other user' do
      let(:other_user) { create :user, email: 'other@other.com' }
      let!(:expected_action) { create :user_action, user: other_user }
      before do
        sign_in current_user
        get :show, {:id => expected_action.to_param}
      end

      context 'when administrator' do
        let(:current_user) { create :administrator }

        describe 'the assigned action' do
          subject { assigns :user_action }
          it 'is the other users action' do
            expect(subject).to eq expected_action
          end
        end
      end

      context 'when user' do
        let(:current_user) { create :user, email: 'self@self.com' }

        describe 'the flash message' do
          subject { flash[:alert] }
          it 'shows user is not authorized' do
            expect(subject).to eq 'You are not authorized to access this page.'
          end
        end

        describe 'the response' do
          subject { response }
          it 'redirects home' do
            expect(subject).to redirect_to root_path
          end
        end
      end
    end
  end

  describe "GET new" do
    before do
      sign_in admin_user
    end
    it "assigns a new user_action as @user_action" do
      get :new, {}
      expect(assigns(:user_action)).to be_a_new(UserAction)
    end
  end

  describe "GET edit" do
    let(:current_user) {admin_user}

    it "assigns the requested user_action as @user_action" do
      sign_in current_user
      user_action = create :user_action
      get :edit, {:id => user_action.to_param}

      expect(assigns(:user_action)).to eq user_action
      expect(subject.response.status).to be 200
    end
  end

  describe "POST create" do
    let(:current_user) {admin_user}

    before do
      sign_in current_user
    end

    describe "with valid params" do
      it "creates a new UserAction" do
        expect {
          post :create, {:user_action => valid_attributes}
        }.to change(UserAction, :count).by(1)
      end

      it "assigns a newly created user_action as @user_action" do
        post :create, {:user_action => {name: 'my action', action_date: Time.new }}

        expect(assigns(:user_action)).to be_a UserAction
        expect(assigns(:user_action)).to be_persisted
      end

      it "redirects to the created user_action" do
        post :create, {:user_action => valid_attributes}
        expect(response).to redirect_to UserAction.last
      end
    end

    describe "with invalid params" do
      before do
        # Trigger the behavior that occurs when invalid params are submitted
        UserAction.any_instance.stub(:save).and_return(false)
        post :create, {:user_action => {'wonk' => 'space'}}
      end

      describe 'the resulting UserAction' do
        subject { assigns(:user_action) }
        it 'is a new UserAction' do
          expect(subject).to be_a_new UserAction
        end
      end

      describe 'the response' do
        subject { response }
        it 'renders the "new" template' do
          expect(subject).to render_template "new"
        end
      end
    end
  end

  describe "PUT update" do
    context "as an admin user" do
      let(:user_action) { create :user_action }

      before do
        sign_in admin_user
      end

      describe "with valid params" do
        before do
          expect(user_action.name).to eq 'factory_action'
          put :update, {:id => user_action.to_param, :user_action => {'name' => 'bob'}}
        end

        describe 'the resulting UserAction' do
          subject { assigns :user_action }
          it { should eq user_action }
          its(:errors) { should be_empty }
          its(:name) {should eq 'bob'}
        end

        describe 'the response' do
          subject { response }
          it { should redirect_to user_action }
        end
      end

      describe "with invalid params" do
        let(:user_action) { create :user_action }
        before do
          UserAction.any_instance.stub(:save).and_return(false)
          put :update, {:id => user_action.to_param, :user_action => {'wonky' => 'parrot'}}
        end

        describe 'the resulting UserAction' do
          subject { assigns :user_action }
          it { should eq user_action }
        end

        it "re-renders the 'edit' template" do
          response.should render_template("edit")
        end
      end
    end
  end

  describe "DELETE destroy" do
    before do
      sign_in admin_user
    end

    it "destroys the requested user_action" do
      user_action = create :user_action
      expect {
        delete :destroy, {:id => user_action.to_param}
      }.to change(UserAction, :count).by(-1)
    end

    it "redirects to the user_actions list" do
      user_action = create :user_action
      delete :destroy, {:id => user_action.to_param}
      response.should redirect_to(user_actions_url)
    end
  end

end
