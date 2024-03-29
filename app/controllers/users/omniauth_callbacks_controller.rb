class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  ADMIN = {}
  def facebook
    # You need to implement the method below in your model
    puts request.env["omniauth.auth"].inspect
    @user = User.find_or_create_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end
