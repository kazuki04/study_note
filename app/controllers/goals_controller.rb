class GoalsController < ApplicationController
  def create
  end

  private
  def goal_params
    params.require(:goal).permit(goal_names:[])
  end
end
