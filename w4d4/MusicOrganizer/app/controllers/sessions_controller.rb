class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    email, password = user_params[:email], user_params[:password]
    @user = User.find_by_credentials(email, password)
    if @user
      log_in!(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def destroy
    log_out!(current_user)
    redirect_to new_session_url
  end
end
