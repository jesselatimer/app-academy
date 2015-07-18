class SubsController < ApplicationController
  before_action :check_login, except: [:index, :show]
  before_action :check_mod, only:[:edit, :update, :destroy]

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    if @sub.save
      ModSub.create!(sub_id: @sub.id, username: current_user.username)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find(params[:id])
    @mods = @sub.mods
    @posts = @sub.posts
    render :show
  end

  def destroy
    @sub = Sub.find(params[:id])
    if @sub
      @sub.destroy!
    else
      flash[:errors] = @sub.errors.full_messages
    end
    redirect_to subs_url
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = ["invalid edit options"]
      render :edit
    end
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
