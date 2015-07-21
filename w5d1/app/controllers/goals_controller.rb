class GoalsController < ApplicationController
  before_action :ensure_logged_in
  before_action :must_own_goal, only: [:edit, :update, :destroy]
  before_action :restrict_private_goals, only: :show

  def index
    @goals = Goal.where("user_id = #{current_user.id} OR privateer = FALSE")
  end

  def show
    @goal = Goal.find(params[:id])
  end

  def new
    @goal = current_user.goals.new
  end

  def create
    @goal = current_user.goals.new(goal_params)
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update(goal_params)
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    goal = Goal.find(params[:id])
    goal.destroy!
    redirect_to goals_url
  end

  private

  def goal_params
    params.require(:goal).permit(:text, :privateer, :completed)
  end

  def must_own_goal
    goal = Goal.find(params[:id])
    unless goal.user_id = current_user.id
      flash[:errors] = ["That's not yours!"]
      redirect_to root_url
    end
  end

  def restrict_private_goals
    goal = Goal.find(params[:id])
    if goal.privateer? && current_user.id != goal.user_id
      flash[:errors] = ["It's a secret."]
      redirect_to root_url
    end
  end
end
