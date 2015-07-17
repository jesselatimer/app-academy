class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in!(user)
    user.reset_session_token!
    self.session[:session_token] = user.session_token
  end

  def log_out!(user)
    user.reset_session_token!
    self.session[:session_token] = nil
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end

  def require_logged_in
    unless logged_in?
      redirect_to new_session_url
    end
  end
end
