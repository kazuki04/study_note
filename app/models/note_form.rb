class NoteForm
  include ActiveModel::Model
  attr_accessor :written_day, :highlight, :excerpt, :body, :note_body, :tag_names, :user_id, :calendar_id, :tags

  with_options presence: true do
    validates :highlight
    validates :excerpt
    validates :set_tag_list
    validates :body
    validates :written_day
  end

  delegate :persisted?, to: :note

  def initialize(attributes = nil, note: Note.new)
    @note = note
    attributes ||= default_attributes
    super(attributes)
  end

  def to_model
    note
  end

  def save
    set_tag_list
    ActiveRecord::Base.transaction do
      tags = @tag_list.map { |tag_name| Tag.where(tag_name: tag_name).first_or_create }
      note.update!(written_day: written_day, highlight: highlight, excerpt: excerpt, tags: tags, body: body, note_body: note_body, user_id: user_id, calendar_id: calendar_id)
    end
  rescue ActiveRecord::RecordInvalid
    false
  end

  private

  attr_reader :note

  def default_attributes
    {
      written_day: note.written_day,
      highlight: note.highlight,
      excerpt: note.excerpt,
      tags: note.tags.pluck(:tag_name).join(","),
      body: note.body,
      user_id: user_id,
      calendar_id: calendar_id
    }
  end

  def set_tag_list
    @tag_list = tag_names.split(",")
  end
end
