class Note < ApplicationRecord

  belongs_to :user
  belongs_to :calendar
  has_many :note_tags
  has_many :tags, through: :note_tags

  def tags_save(tag_list)
    if self.tags != nil
      self.tags.destroy_all
    end

    tag_list.each do |tag_name|
      tag = Tag.where(tag_name: tag_name).first_or_create
      self.tags << tag
    end
  end
end
