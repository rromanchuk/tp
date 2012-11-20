# token_authentications_controller.rb
class TokenAuthenticationsController < ApplicationController 
  skip_before_filter :verify_authenticity_token
  respond_to :json

  def create
    @user = User.find_by_uid(params[:uid])
    unless @user
      facebook_user = FbGraph::User.fetch(params[:uid], :access_token => params[:facebook_access_token])
      puts facebook_user.inspect
      array = FbGraph::Query.new('SELECT current_location FROM user WHERE uid = me()').fetch(params[:facebook_access_token]).first
      city = array["current_location"]["city"]
      state = array["current_location"]["state"]
      zip = array["current_location"]["zip"]
      @user = User.create!(:email => facebook_user.email, :uid => facebook_user.identifier, :name => facebook_user.name) 
    end

    @user.ensure_authentication_token!
    respond_with @user
  end

  def destroy
    @user = User.criteria.id(params[:id]).first
    @user.authentication_token = nil
    @user.save
    redirect_to edit_user_registration_path(@user)
  end

end