class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :check_login, :is_mod?

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def login!(user)
    user.reset_session_token!
    self.session[:session_token] = user.session_token
  end

  def logout!(user)
    user.reset_session_token!
    self.session[:session_token] = nil
  end

  def current_user
    User.find_by(session_token: self.session[:session_token])
  end

  def is_mod?(sub)
    sub.mods.include?(current_user)
  end

  def check_login
    unless current_user
      flash[:errors] = ["Must be logged in."]
      redirect_to new_session_url
    end
  end

  def check_mod
    subx = Sub.find(params[:id])
    unless is_mod?(subx)
      flash[:errors] = ["Only mods can do that"]
      redirect_to subs_url
    end
  end

end
