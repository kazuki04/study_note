class GoalsController < ApplicationController
  def create_goal
    selected_month = Calendar.find(params[:calendar_id])
    @goals = selected_month.goals

    update_array = []
    goal_params
    if @goals.empty?
      @goal_parameters.each do |goal_name|
        goal = Goal.create(goal_name: goal_name, calendar_id: params[:calendar_id], user_id: current_user.id)
        update_array.push(goal)
      end
    else
      @goals.each(&:destroy)
      @goal_parameters.each do |goal_name|
        if goal_name != "0"
          goal = Goal.create(goal_name: goal_name, calendar_id: selected_month.id, user_id: current_user.id)
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
    binding.pry
    @goals.each_with_index do |goal, i|
      goal_name = params.require(:goal)[:goal_names][i]
      goal.update(goal_name: goal_name)
    end
  end

  private

  def goal_params
    # @goal_parameters = params.require(:goal_params)
    @goal_parameters = params.require(:form_values)
  end
end
