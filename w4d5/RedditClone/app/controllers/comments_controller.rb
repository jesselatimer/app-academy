class CommentsController < ApplicationController

  def new
    @comment = Comment.new(post_id: params[:post_id])
    render :new
  end

  def create
    input = comment_params
    input[:author_id] = current_user.id
    input[:post_id] = params[:post_id]
    @comment = Comment.new(input)
    if @comment.save
      redirect_to post_url(params[:post_id])
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
