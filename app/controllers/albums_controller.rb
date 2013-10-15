class AlbumsController < ApplicationController
  def index
    @albums = Album.includes(:artist).recent_top(Album.count)
    render :index
  end

  def show
    @album = Album.includes([:songs, :artist]).find(params[:id])
    render :show
  end

  def create
    @album = Album.new(params[:album])

    if @album.save
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end
end
