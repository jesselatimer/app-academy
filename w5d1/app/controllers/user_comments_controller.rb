class UserCommentsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @comment = current_user.authored_user_comments.new(user_comment_params)
    if @comment.save
      redirect_to user_url(@comment.user)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to user_url(@comment.user)
    end
  end

  def destroy
    comment = UserComment.find(params[:id])
    comment.destroy!
    redirect_to user_url(comment.user)
  end

  def edit
    @comment = UserComment.find(params[:id])
  end

  def update
    @comment = UserComment.find(params[:id])
    if @comment.update(user_comment_params)
      redirect_to user_url(@comment.user)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :edit
    end
  end

  private

  def user_comment_params
    params.require(:user_comment).permit(:user_id, :body)
  end

end
