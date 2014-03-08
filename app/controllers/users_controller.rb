class UsersController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  check_authorization
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @available_roles = Role.all
  end

  # GET /users/1/edit
  def edit
    @available_roles = Role.all
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @available_roles = Role.all
    role_ids = params[:selected_roles]
    respond_to do |format|
      if @user.update(user_params)
        if can? :update, Role
          if @user.update_roles(role_ids)
            if current_user.email == 'superuser@meritbadges.com'
              sign_out current_user
              format.html { redirect_to root_path, alert: 'Logged out superuser since you updated a user. Login as a real person now.' }
            else
              format.html { redirect_to @user, notice: 'User was successfully updated.' }
              format.json { head :no_content }
            end
          end
        else
          format.html { redirect_to @user, notice: 'User was successfully updated - except the roles.' }
          format.json { head :no_content }
        end

      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :disabled)
  end
end
