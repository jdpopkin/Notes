class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    if @comment.save
      render json: @comment
    else
      render json: @comment.errors
    end
  end
end
