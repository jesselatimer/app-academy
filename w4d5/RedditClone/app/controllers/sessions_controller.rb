class SessionsController < ApplicationController

  def create
    username = user_params[:username]
    password = user_params[:password]
    @user = User.find_by_credentials(username, password)
    if @user
      login!(@user)
      redirect_to :subs
    else
      flash.now[:errors] = ["Invalid login"]
      render :new
    end
  end

  def new
    render :new
  end

  def destroy
    logout!(current_user)
    redirect_to :back
  end

end
