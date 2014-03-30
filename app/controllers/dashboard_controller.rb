class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def new_action

  end

  def save_new_action
    @user_action = UserAction.new(name: params[:name], user: current_user, action_date: Time.new)
    @user_action.save!

    redirect_to action: 'index'
  end
end
