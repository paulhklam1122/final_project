class CallbacksController < ApplicationController
  def google
    google_data = request.env['omniauth.auth']
    user = User.find_or_create_from_google google_data
    sign_in(user)
    redirect_to root_path, notice: "Thanks for signing in with Google!"
  end
  def facebook
    facebook_data = request.env['omniauth.auth']
    user = User.find_or_create_from_facebook facebook_data
    sign_in(user)
    redirect_to root_path, notice: "Thanks for signing in with Facebook!"
  end
end
