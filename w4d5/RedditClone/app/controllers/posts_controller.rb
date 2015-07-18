class PostsController < ApplicationController
  before_action :check_login, except: [:show]

  helper_method :is_author?

  def new
    @subs = Sub.all
    @post = Post.new
    @sub_ids = []
    render :new
  end

  def create
    @subs = Sub.all
    input = post_params
    input[:author_id] = current_user.id
    @post = Post.new(input)
    @sub_ids = []
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def show
    @subs = Sub.all
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:author)
    render :show
  end

  def destroy
    @post = Post.find(params[:id])
    if @post
      @post.destroy!
    else
      flash[:errors] = @post.errors.full_messages
    end
    redirect_to subs_url
  end

  def edit
    @subs = Sub.all
    @post = Post.find(params[:id])
    @sub_ids = @post.subs.pluck(:id)
    render :edit
  end

  def update
    @subs = Sub.all
    @post = Post.find(params[:id])
    @sub_ids = @post.subs.pluck(:id)
    if @post.update(post_params)
      redirect_to post_url(@post)
    else
      flash.now[:errors] = ["invalid edit options"]
      render :edit
    end
  end

  def post_params
    params.require(:post).permit(:title, :url, :content, sub_ids: [])
  end

  def is_author?(post)
    current_user.id == post.author_id
  end

  def check_author
    post = Post.find(params[:id])
    unless is_author?(post)
      flash[:errors] = ["Only authors can do that"]
      redirect_to subs_url
    end
  end

end
