class Api::RegistrationsController < Api::BaseController
  
  respond_to :json
  def create
    if params[:user].has_key?(:access_token)
      fbu = FbGraph::User.me(params[:user][:access_token]).fetch
      attributes = {
        :facebook_access_token => params[:user][:access_token],
        :facebook_id           => fbu.identifier,
        :email                 => fbu.email,
        :name                  => fbu.name,
        :password              => Devise.friendly_token[0,20]
      }
    end

    user = User.find_by_email(fbu.email) ||
             User.find_by_facebook_id(fbu.identifier) ||
             User.find_by_facebook_access_token(params[:user][:access_token]) ||
             User.create(attributes)


    if user.save
      render :json=> user.as_json(:auth_token=>user.authentication_token, :email=>user.email), :status=>201
      return
    else
      warden.custom_failure!
      render :json=> user.errors, :status=>422
    end
  end
end