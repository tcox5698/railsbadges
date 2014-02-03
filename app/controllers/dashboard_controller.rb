class DashboardController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def log_action

  end
end
