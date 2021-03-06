class CalendarsController < ApplicationController
  def index; end

  def show
    @today = Date.today
    @note = Note.find_by(written_day: @today, user_id: current_user.id)
    set_selected_month()
    
    @last_month = if @selected_month.id != 1
                    Calendar.find(@selected_month.id - 1)
                  else
                    Calendar.find_by(year: @today.year, month: @today.month)
                  end

    if (@selected_month.id + 1) == 8
      # redirect_to root_path
    else
      @next_month = Calendar.find(@selected_month.id + 1)
    end

    if @selected_month.goals.empty?
      @goal = @selected_month.goals.new
    else
      @goals = @selected_month.goals
      @goal = @goals[0]
    end

    @notes = Note.where(calendar_id: @selected_month.id, user_id: current_user.id).includes(:tags)
  end


  private

  def set_selected_month
    if params[:id].nil?
      @selected_month = Calendar.find_by(year: @today.year, month: @today.month)
      redirect_to calendar_path(@selected_month)
    else
      @selected_month = Calendar.find(params[:id])
    end
  end
end
