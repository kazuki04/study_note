class NotesController < ApplicationController
  before_action :set_selected_month, only: %i[new create show edit update]
  before_action :set_today_date, only: %i[new create edit update]
  before_action :set_note, only: %i[show edit update]
  before_action :user_confirmation, only: %i[edit update]

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
    @reviewed_record = ReviewRecord.where(note_id: @note.id).first_or_initialize.reviewed_count
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
      @note_form = NoteForm.new(note: @note)
      render :edit
    end
  end

  def incremental_search_tags
    params_array = params[:all_input_val].split(",")
    tags = Tag.where('tag_name LIKE ?', "%#{params[:input_val]}%").limit(10)

    # カンマが含まれている(まだ登録していない)か否かで条件分岐
    if params[:all_input_val].include?(",")
      tags.each_with_index do |tag, _i|
        params_array.each do |tag_name|
          tags = tags.where.not(tag_name: tag.tag_name) if tag.tag_name == tag_name
        end
      end
    end

    render json: { tags: tags }
  end

  def search_note
    search_input_val = params[:search_input_val]
    return false unless search_input_val.match(/^[ぁ-んー－]{1,1}$/).nil?

    search_result = Note.where("note_body LIKE ?", "%#{search_input_val}%")
    # search_result = ActiveRecord::Base.connection.select_all("select * from action_text_rich_texts where body like '%#{search_input_val}%'")
    
    response_array = []
    # noteのbodyの内容を抽出する→抽出したものを返す
    search_target = 0
    search_result.each do |note_record|
      i = 0
      note_record.note_body.each_char do |_letter|
        # bodyの0番目から、入力された文字分の範囲で検索
        if note_record.note_body.slice(i, search_input_val.length) == search_input_val
          # bodyの中の何番目の文字かを変数に代入
          search_target = i
        end
        i += 1
      end
      # search_target+search_input_val.length+10で検索ワードの文字数＋10
      extracted_body = note_record.note_body.slice(search_target - 10..search_target + search_input_val.length + 10)
      response_array << { highlight: note_record.highlight, extracted_body: extracted_body, calendar_id: note_record.calendar_id, note_id: note_record.id }
    end

    render json: { response_array: response_array }
  end

  private

  def note_params
    params.require(:note).permit(:written_day, :highlight, :tag_names, :excerpt, :body, :note_body).merge(user_id: current_user.id, calendar_id: @selected_month.id)
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