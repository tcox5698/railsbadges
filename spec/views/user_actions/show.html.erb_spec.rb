require 'spec_helper'

describe "user_actions/show" do
  before(:each) do
    @user_action = assign(:user_action, stub_model(UserAction))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
