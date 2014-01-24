class UserSessionsController < Devise::SessionsController

  def create
    super
    flash[:alert] = 'MeritBadges is not initialized.  Please log in as superuser and configure another user as superuser.'
  end
end