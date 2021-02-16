class CalendarsController < ApplicationController
  def index
    
  end

  def show

    today = Date.today
    if params[:id] == nil
      @selected_month = Calendar.find_by(year: today.year, month: today.month)
      redirect_to calendar_path(@selected_month)
    else
      @selected_month = Calendar.find(params[:id])
    end

    if @selected_month.id != 1
      @last_month = Calendar.find(@selected_month.id - 1)
    else
      @last_month = Calendar.find_by(year: today.year, month: today.month)
    end
    
    if (@selected_month.id + 1) == 7
      redirect_to root_path
    else
      @next_month = Calendar.find(@selected_month.id + 1)
    end

    if @selected_month.goals.empty?
      @goal = @selected_month.goals.new
    else
      @goal = @selected_month.goals
    end
  end
end
