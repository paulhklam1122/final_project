class FollowsController < ApplicationController
  before_action :authenticate_user!

  def index
    @goals = current_user.followed_goals
  end

  def create
    @goal = Goal.find params[:goal_id]
    @user = User.find params[:user_id]
    @follow = Follow.new(goal: @goal, user: current_user)
    @follow.save
    respond_to do |format|
      format.html {redirect_to user_path(@user), notice: "Thanks for favouriting!"}
      format.js {render :toggle_follow}
    end
  end

  def destroy
    @goal = Goal.find params[:goal_id]
    @user = User.find params[:user_id]
    @follow = Follow.find params[:id]
    @follow.destroy
    respond_to do |format|
      format.html {redirect_to user_path(@user), notice: "Un-followed"}
      format.js {render :toggle_follow}
    end
  end
end
