class GoalsController < ApplicationController
  def create
    create_goal_names()
  end

  private

  def create_goal_names
    goal_names = params.require(:goal)[:goal_names]
    goal_names.each do |goal|
      Goal.create(goal_name: goal, calendar_id: params[:calendar_id])
    end
  end
end
