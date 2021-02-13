class NotesController < ApplicationController
  before_action :set_today_date, only: [:new, :create, :edit]
  before_action :set_note, only: [:show, :edit, :update]

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to root_path
    else
      render :new
    end
    
  end

  def show
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
    params.require(:note).permit(:written_day, :highlight, :excerpt, :body).merge(user_id: current_user.id)
  end

  def set_today_date
    @today_date = Date.today
  end

  def set_note
    @note = Note.find(params[:id])
  end
end