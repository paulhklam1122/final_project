class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def user_signed_in?
    session[:user_id].present?
  end
  helper_method :user_signed_in?

  def sign_in(user)
    session[:user_id] = user.id
  end

  def authorize_owner
    redirect_to root_path, alert: "Access Denied" unless can? :manage
  end
  helper_method :authorize_owner

  def authenticate_user!
    redirect_to new_session_path, alert: "Please Sign In" unless user_signed_in?
  end
end
