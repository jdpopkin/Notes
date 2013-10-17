class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    @comment.user_id = current_user.id
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors
    end
  end
end
