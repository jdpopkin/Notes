class VotesController < ApplicationController
  def create
    @vote = Vote.new(params[:vote])

    if @vote.save
      render json: @vote
    else
      render json: @vote.errors
    end

  end
end
