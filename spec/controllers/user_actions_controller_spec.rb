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
          it 'should include all the actions' do
            subject.should eq [user_action, admin_action]
          end
        end

        describe 'when user' do
          let(:current_user) { user }
          it 'should include only the users actions' do
            subject.should eq [user_action]
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
          it { should eq expected_action }
        end
      end

      context 'when user' do
        let(:current_user) { create :user, email: 'self@self.com' }

        describe 'the flash message' do
          subject { flash[:alert] }
          it { should eq 'You are not authorized to access this page.' }
        end

        describe 'the response' do
          subject { response }
          it{ should redirect_to root_path }
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
      assigns(:user_action).should be_a_new(UserAction)
    end
  end

  describe "GET edit" do
    it "assigns the requested user_action as @user_action" do
      user_action = create :user_action
      get :edit, {:id => user_action.to_param}
      assigns(:user_action).should eq(user_action)
      subject.response.should redirect_to 'bob'
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new UserAction" do
        expect {
          post :create, {:user_action => valid_attributes}
        }.to change(UserAction, :count).by(1)
      end

      it "assigns a newly created user_action as @user_action" do
        post :create, {:user_action => valid_attributes}
        assigns(:user_action).should be_a(UserAction)
        assigns(:user_action).should be_persisted
      end

      it "redirects to the created user_action" do
        post :create, {:user_action => valid_attributes}
        response.should redirect_to(UserAction.last)
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
        it { should be_a_new UserAction }
      end

      describe 'the response' do
        subject { response }
        it { should render_template "new" }
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
          UserAction.any_instance.should_receive(:update).with({'name' => 'bob'}).and_call_original
          put :update, {:id => user_action.to_param, :user_action => {'name' => 'bob'}}
        end

        describe 'the resulting UserAction' do
          subject { assigns :user_action }
          it { should eq user_action }
          its(:errors) { should be_empty }
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
