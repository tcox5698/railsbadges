require 'spec_helper'

describe "user_actions/index" do
  before(:each) do
    assign(:user_actions, [
      stub_model(UserAction),
      stub_model(UserAction)
    ])
  end

  it "renders a list of user_actions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
