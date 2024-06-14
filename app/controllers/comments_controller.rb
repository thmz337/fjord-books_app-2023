# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    @comment = @commentable.comments.create(comment_params)
    @comment.user = current_user
  end

  def destroy
    return unless @comment.user_id == current_user.id

    @comment.destroy!
  end

  def get_comment(commentable)
    @comment = commentable.comments.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
