class NotesController < ApplicationController

  def create
    @note = Note.new(params[:note])
    if request.xhr?
      if @note.save
        render json: @note.to_json(include: :user)
      else
        render json: @note.errors
      end
    else
      redirect_to song_url(@note.song_id)
    end
  end
end
