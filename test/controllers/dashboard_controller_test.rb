require 'test_helper'

class DashboardControllerTest < ActionController::TestCase
    test 'should get index' do
        user = User.new(email: 'x@y.com', password: 'passw', password_confirmation: 'passw',
                            confirmed_at: Time.now)
        user.save!
        sign_in user
        get :index
        assert_response :success
    end

end
