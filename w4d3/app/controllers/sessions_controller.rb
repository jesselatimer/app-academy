class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:users][:user_name],
      params[:users][:password]
    )

    if user
      log_in!(user)
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end

  def destroy
    log_out!
    redirect_to :back
  end

  private
  def session_params
    params.require(:session).permit(:user_name, :password)
  end

end
