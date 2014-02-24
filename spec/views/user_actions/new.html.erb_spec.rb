require 'spec_helper'

describe "user_actions/new" do
  before(:each) do
    assign(:user_action, stub_model(UserAction).as_new_record)
  end

  it "renders new user_action form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_actions_path, "post" do
    end
  end
end
