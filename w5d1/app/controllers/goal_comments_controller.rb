class GoalCommentsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @comment = current_user.authored_user_comments.new(goal_comment_params)
    if @comment.save
      redirect_to user_url(@comment.user)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to user_url(@comment.user)
    end
  end

  def destroy
    comment = GoalComment.find(params[:id])
    comment.destroy!
    redirect_to user_url(comment.user)
  end

  def edit
    @comment = GoalComment.find(params[:id])
  end

  def update
    @comment = GoalComment.find(params[:id])
    if @comment.update(goal_comment_params)
      redirect_to user_url(@comment.user)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :edit
    end
  end

  private

  def goal_comment_params
    params.require(:user_comment).permit(:goal_id, :body)
  end
end
