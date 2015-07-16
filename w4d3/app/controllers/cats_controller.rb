class CatsController < ApplicationController
  before_action :check_owner, only: [:update, :edit]
  before_action :logged_in, only: [:new, :create]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    params[:cat][:user_id] = current_user.id
    @cat = Cat.new(cat_params)
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat)
      .permit(:age, :birth_date, :color, :description, :name, :sex, :user_id)
  end

  def check_owner
    @cat = Cat.find_by(id: params[:id])
    unless current_user && current_user.id == @cat.user_id
      flash[:errors] = ["Can't edit other people's cats."]
      redirect_to :back
    end
  end
end
