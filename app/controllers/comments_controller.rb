# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[destroy]

  def create
    @comment = @commentable.comments.create(comment_params)
    @comment.user = current_user
  end

  def destroy
    return unless @comment.user_id == current_user.id

    @comment.destroy!
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
