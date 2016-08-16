class GoalsController < ApplicationController
  def create
    @goal = Goal.new goal_params
    @goal.user = current_user
    if @goal.save
      redirect_to edit_user_path(current_user), notice: "Changes Saved!"
    else
      redirect_to edit_user_path(current_user), alert: "Unable To Save"
    end
  end

  def edit
    @user = current_user
    @goal = @user.goals.find params[:id]
    # respond_to do |format|
    #   format.js {render :edit_toggle}
    # end
  end

  def show
    @user = User.find params[:user_id]
    @goal = @user.goals.find params[:id]
  end

  def update
    @user = current_user
    @goal = @user.goals.find params[:id]
    # respond_to do |format|
      if @goal.update goal_params
        redirect_to user_path(current_user), notice: "Goal Updated!"
        # format.js {render :update_success}
      else
        render :edit
      end
    # end
  end

  def destroy
    @user = current_user
    @goal = @user.goals.find params[:id]
    @goal.destroy
    # respond_to do |format|
      redirect_to user_path(current_user), notice: "Goal Deleted!"
    # end
  end

  def mark
    @user = current_user
    @goal = @user.goals.find params[:id]
    Goal.mark @goal
    respond_to do |format|
    GoalsMailer.notify_following_user(@goal).deliver_now if @goal.mark == "Not Achieved"
      format.html {redirect_to user_path(@user), notice: "Good job at completing your goal! A bragging email has been sent to your followers."}
      format.js {render :mark}
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:goal_name, :amount, :image, :location)
  end

end
