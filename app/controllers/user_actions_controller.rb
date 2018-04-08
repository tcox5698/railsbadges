# == Schema Information
#
# Table name: user_actions
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  action_date :datetime
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_user_actions_on_user_id  (user_id)
#

class UserActionsController < ApplicationController
  before_action :set_user_action, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!
  check_authorization
  authorize_resource

  # GET /user_actions
  # GET /user_actions.json
  def index
    @user_actions = UserAction.accessible_by current_ability
  end

  # GET /user_actions/1
  # GET /user_actions/1.json
  def show
    @user_action = UserAction.find(params[:id])
    authorize! :read, @user_action
  end

  # GET /user_actions/new
  def new
    @user_action = UserAction.new
  end

  # GET /user_actions/1/edit
  def edit
  end

  # POST /user_actions
  # POST /user_actions.json
  def create
    @user_action = UserAction.new(user_action_params)

    @user_action.user = current_user if user_action_params[:user_id].blank?
    @user_action.action_date = Time.new if @user_action.action_date.nil?

    respond_to do |format|
      if @user_action.save
        format.html { redirect_to @user_action, notice: 'User action was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user_action }
      else
        format.html { render action: 'new' }
        format.json { render json: @user_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_actions/1
  # PATCH/PUT /user_actions/1.json
  def update
    respond_to do |format|
      if @user_action.update(user_action_params)
        format.html { redirect_to @user_action, notice: 'User action was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user_action.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_actions/1
  # DELETE /user_actions/1.json
  def destroy
    @user_action = UserAction.find params[:id]
    @user_action.destroy
    respond_to do |format|
      format.html { redirect_to user_actions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_action
      @user_action = UserAction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_action_params
      params.require(:user_action).permit(:name, :action_date)
    end
end
