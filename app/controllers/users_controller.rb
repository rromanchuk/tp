class UsersController < ApplicationController

  respond_to :json
  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    respond_with @user
  end

  def index 
    @users = User.all
  end
end