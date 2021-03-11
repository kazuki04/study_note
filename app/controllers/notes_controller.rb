class NotesController < ApplicationController
  before_action :set_selected_month, only: [:new, :create, :show, :edit, :update]
  before_action :set_today_date, only: [:new, :create, :edit]
  before_action :set_note, only: [:show, :edit, :update]
  before_action :user_confirmation, only: [:edit, :update]

  def new
    # @note = Note.new
    @note_form = NoteForm.new
  end

  def create
    # @note = Note.new(note_params)
    @note_form = NoteForm.new(note_params)

    if @note_form.save
      redirect_to root_path
    else
      render :new
    end
    
  end

  def show
  end

  def edit
    @note_form = Note.find(params[:id])
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
    params.require(:note_form).permit(:written_day, :highlight, :tag_names, :excerpt, :body).merge(user_id: current_user.id, calendar_id: @selected_month.id)
  end
  
  def set_selected_month
    @selected_month = Calendar.find(params[:calendar_id]) 
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
