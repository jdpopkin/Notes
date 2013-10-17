class AlbumsController < ApplicationController
  def index
    @albums = Album.includes(:artist).recent_top(Album.count).page(params[:page]).per(4)
    render :index
  end

  def show
    @album = Album.includes([:songs, :artist]).find(params[:id])
    render :show
  end

  def create
    @album = Album.new(params[:album])
    @album.user_id = current_user.id

    if @album.save
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end
end
