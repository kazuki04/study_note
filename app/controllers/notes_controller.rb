class NotesController < ApplicationController
  before_action :set_selected_month, only: [:new, :create, :show, :edit, :update]
  before_action :set_today_date, only: [:new, :create, :edit, :update]
  before_action :set_note, only: [:show, :edit, :update]
  before_action :user_confirmation, only: [:edit, :update]

  def new
    @note_form = NoteForm.new
  end

  def create
    @note_form = NoteForm.new(note_params)

    if @note_form.valid?
      @note_form.save
      redirect_to root_path
    else
      render :new
    end
    
  end

  def show
  end

  def edit
    @note_form = NoteForm.new(note: @note)
  end

  def update
    @note_form = NoteForm.new(note_params, note: @note)
    if @note_form.valid?
      @note_form.save
      redirect_to root_path
    else
      render :edit
    end
  end

  def incremental_search_tags
    params_array = params[:all_input_val].split(",")
    tags = Tag.where('tag_name LIKE ?', "%#{params[:input_val]}%").limit(10)

    # カンマが含まれている(まだ登録していない)か否かで条件分岐
    if (params[:all_input_val].include?(","))
      tags.each_with_index do |tag, i|
        params_array.each do |tag_name|
          if tag.tag_name == tag_name
            tags = tags.where.not(tag_name: tag.tag_name)
          end
        end
      end
    end


    render  json: {tags: tags}
  end

  private
  def note_params
    params.require(:note).permit(:written_day, :highlight, :tag_names, :excerpt, :body).merge(user_id: current_user.id, calendar_id: @selected_month.id)
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
