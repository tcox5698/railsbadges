require "spec_helper"

describe UserActionsController do
  describe "routing" do

    it "routes to #index" do
      get("/user_actions").should route_to("user_actions#index")
    end

    it "routes to #new" do
      get("/user_actions/new").should route_to("user_actions#new")
    end

    it "routes to #show" do
      get("/user_actions/1").should route_to("user_actions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/user_actions/1/edit").should route_to("user_actions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/user_actions").should route_to("user_actions#create")
    end

    it "routes to #update" do
      put("/user_actions/1").should route_to("user_actions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/user_actions/1").should route_to("user_actions#destroy", :id => "1")
    end

  end
end
