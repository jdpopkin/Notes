class SongsController < ApplicationController

  def index
    @songs = Song.all

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

    if @song.save
      redirect_to song_url(@song)
    else
      render_json @song.errors
    end
  end
end
