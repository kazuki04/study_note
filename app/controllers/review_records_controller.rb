class ReviewRecordsController < ApplicationController
  def create
    review_record = ReviewRecord.where(note_id: Note.find(params[:id])).first_or_initialize
    review_record.update(reviewed_count: review_record.reviewed_count + 1, last_reviewed_date: Date.today)
    @reviewed_count = Note.find(params[:id]).review_record.reviewed_count
  end

  def destroy

  end
end
