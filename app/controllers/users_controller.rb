class UsersController < ActionController::Base

  respond_to :json
  def show
    @user = User.find(params[:id])
    respond_with @user
  end
end