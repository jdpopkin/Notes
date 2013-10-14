class RootController < ApplicationController

  def root
    render :root
  end

  def search
    @query = params[:search][:query]
    @results = PgSearch.multisearch(params[:search][:query])
    render :search
  end
end
