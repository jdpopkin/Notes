class VotesController < ApplicationController
  def create
    @vote = Vote.new(params[:vote])
    @vote.user_id = current_user.id
    other_vote = Vote.where(user_id: @vote.user_id, votable_id: @vote.votable_id,
                            votable_type: @vote.votable_type).first
    other_vote.destroy if other_vote

    if @vote.save
      render json: @vote
    else
      render json: @vote.errors
    end

  end
end
