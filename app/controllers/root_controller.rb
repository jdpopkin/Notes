class RootController < ApplicationController

  def root
    render :root
  end

  def search
    @results = PgSearch.multisearch(params[:search][:query])
    render :search
  end
end
