class NotesController < ApplicationController
  before_action :set_today_date, only: [:new, :create, :edit]
  before_action :set_note, only: [:show, :edit, :update]
  before_action :user_confirmation, only: [:edit, :update]

  def new
    @selected_month= Calendar.find(params[:calendar_id])
    @note = Note.new
  end

  def create
    @selected_month= Calendar.find(params[:calendar_id])
    @note = Note.new(note_params)
    binding.pry
    if @note.save
      redirect_to root_path
    else
      render :new
    end
    
  end

  def show
    @selected_month= Calendar.find(params[:calendar_id]) 
  end

  def edit
  end

  def update
    if @note.update(note_params) 
      redirect_to root_path
    else
      render :edit
    end
  end

  private
  def note_params
    params.require(:note).permit(:written_day, :highlight, :excerpt, :body).merge(user_id: current_user.id, calendar_id: @selected_month.id)
  end

  def set_today_date
    @today_date = Date.today
  end

  def set_note
    @note = Note.find(params[:id])
  end

  def user_confirmation
    redirect_to root_path if current_user.id != @note.user_id
  end
end
