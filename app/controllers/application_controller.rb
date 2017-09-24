class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  # before_action :require_user, except: [login, signup]

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def require_user
    redirect_to login_path unless current_user
  end
end
