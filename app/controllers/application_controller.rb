class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :user_reservation, :valid_time_to_check_out?
  before_action :require_user

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def user_reservation
    @reservation = Reservation.where(:user_id => current_user.id).where(:status => "Current").first
  end

  def valid_time_to_check_out?
    @reservation = user_reservation
    if @reservation
      time_diff = @reservation.from - DateTime.now
      puts "CheckOut Time Diff: #{time_diff}"
      if(time_diff <= 36000)
        return true
      end
    end
  end

  def not_logged_in
    redirect_to root_path if logged_in?
  end

  def require_user
    redirect_to login_path unless current_user
  end
end
