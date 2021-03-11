class NoteForm
  include ActiveModel::Model
  attr_accessor :written_day, :highlight, :excerpt, :body, :tag_names, :user_id, :calendar_id

  with_options presence: true do
    validates :highlight
    validates :excerpt
    validates :body
    validates :written_day
  end

  def save
    note = Note.new(written_day: written_day, highlight: highlight, excerpt: excerpt, body: body, user_id: user_id, calendar_id: calendar_id)
    set_tag_list()
    note.tags_save(@tag_list)
    note.save
  end


  def set_tag_list
    @tag_list = tag_names.split(",")
  end

end