class SongsController < ApplicationController

  def index
    @songs = Song.includes(:artist).recent_top(Song.count).page(params[:page]).per(4)

    render :index
  end

  def show
    @song = Song.find(params[:id], include: [:comments, notes: :comments])
    render :show
  end

  def new
    render :new
  end

  def create
    @song = Song.new(params[:song])
    @song.user_id = current_user.id

    if @song.save
      # redirect_to song_url(@song)
      render json: @song
    else
      render json: @song.errors, status: :unprocessable_entity
    end
  end
end
