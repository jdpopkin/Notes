class ArtistsController < ApplicationController

  def index
    @artists = Artist.recent_top(Artist.count)
    render :index
  end

  def show
    @artist = Artist.find(params[:id])
    render :show
  end

  def create
    @artist = Artist.new(params[:artist])

    if @artist.save
      render :show
    else
      render json: @artist.errors
    end

  end
end
