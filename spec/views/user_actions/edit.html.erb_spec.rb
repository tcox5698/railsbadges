require 'spec_helper'

describe "user_actions/edit" do
  before(:each) do
    @user_action = assign(:user_action, stub_model(UserAction))
  end

  it "renders the edit user_action form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_action_path(@user_action), "post" do
    end
  end
end
