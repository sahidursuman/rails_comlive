class Auth0Controller < ApplicationController
  def callback
    # This stores all the user information that came from Auth0 and the IdP
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id

    user.accept_invite(params[:state]) if params[:state]
    user.create_default_app if !params[:state] && !user.default_app

    # Redirect to the URL you want after successfull auth
    redirect_to after_sign_in_path, notice: "Signed in successfully"
  end

  def failure
    # show a failure page or redirect to an error page
    redirect_to root_path, alert: params['message']
  end

  private

  def after_sign_in_path
    root_path
  end
end
