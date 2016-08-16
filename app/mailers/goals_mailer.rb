class GoalsMailer < ApplicationMailer
  def notify_following_user(goal)
    @goal = goal
    @owner = goal.user.first_name
    @goal.follows.each do |follow|
      @follower = User.find follow.user_id
      mail(to: @follower.email, subject: "#{@owner} has reached his goal!")
    end
  end
end
