class NotesController < ApplicationController

  def create
    @note = Note.new(params[:note])
    if @note.save
      render json: @note
    else
      render json: @note.errors
    end
  end
end
