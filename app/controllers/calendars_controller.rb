class CalendarsController < ApplicationController
  def index
    
  end

  def show
    @calendar = Calendar.find(1)
    @goal = Goal.new
    @calendar.goals.new if @calendar.goals.empty?
  end
end
