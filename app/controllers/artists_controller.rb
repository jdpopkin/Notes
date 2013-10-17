class ArtistsController < ApplicationController

  def index
    @artists = Artist.recent_top(Artist.count)
    render :index
  end

  def show
    @artist = Artist.includes(:songs).find(params[:id])
    render :show
  end

  def create
    @artist = Artist.new(params[:artist])
    @artist.user_id = current_user.id

    if @artist.save
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end

  end
end
