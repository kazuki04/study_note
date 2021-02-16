class GoalsController < ApplicationController
  def create
    create_goal_names()
  end

  def update
    @selected_month = Calendar.find(params[:id])
    goals = @selected_month.goals
    goals.each_with_index do |goal, i|
      goal_name = params.require(:goal)[:goal_names][i] 
        goal.update(goal_name: goal_name)
      end
  end


  private

  def create_goal_names
    goal_names = params.require(:goal)[:goal_names]
    goal_names.each do |goal|
      Goal.create(goal_name: goal, calendar_id: params[:calendar_id])
    end
  end
end
