class UserSessionsController < Devise::SessionsController


  # POST /resource/sign_in
  def create
    super

    if self.resource.email == 'superuser@meritbadges.com'
      if Role.find_by_name('superuser').users.count < 2
        flash[:alert] = 'MeritBadges is not initialized.  Please configure another user as superuser.'
      else
        sign_out
        flash[:alert] = 'Default superuser is now disabled.  Please login as a real person.'
      end
    elsif Role.find_by_name('superuser').users.count < 2
      sign_out
      flash[:alert] = 'MeritBadges is not initialized.  Please login as superuser and configure another user as superuser.'
    end

  end
end