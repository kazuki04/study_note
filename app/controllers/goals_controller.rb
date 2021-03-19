class GoalsController < ApplicationController
  def create_goal
    selected_month = Calendar.find(params[:calendar_id])
    @goals = selected_month.goals

    update_array = []
    goal_params
    if @goals.empty?
      @goal_parameters.each do |goal_parameter|
        goal_name = goal_parameter[1].require(:value)
        goal = Goal.create(goal_name: goal_name, calendar_id: params[:calendar_id], user_id: current_user.id)
        update_array.push(goal)
      end
    else
      @goals.each(&:destroy)
      params.require(:goal_params).each do |parameter|
        if parameter[0] != "0"
          goal = Goal.create(goal_name: parameter[1][:value], calendar_id: selected_month.id, user_id: current_user.id)
          update_array.push(goal)
        end
      end
    end

    goal_name_array = []
    if @goals.empty?
      @goals.each do |goal|
        goal_name_array.push(goal.goal_name)
      end
    else
      update_array.each do |goal|
        goal_name_array.push(goal.goal_name)
      end
    end

    render json: goal_name_array
  end

  def update
    @selected_month = Calendar.find(params[:id])
    @goals = @selected_month.goals
    @goals.each_with_index do |goal, i|
      goal_name = params.require(:goal)[:goal_names][i]
      goal.update(goal_name: goal_name)
    end
  end

  private

  def goal_params
    @goal_parameters = params.require(:goal_params)
  end
end
