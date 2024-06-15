# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    commentable_class_name = @commentable.class.name.downcase
    @comment = @commentable.comments.create(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render "#{commentable_class_name}s/show", status: :unprocessable_entity
    end
  end

  def destroy
    redirect_to @commentable, alert: t('controllers.common.alert_destroy', name: Comment.model_name.human) unless @comment.user_id == current_user.id

    @comment.destroy!

    redirect_to @commentable, notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  def set_comment
    @comment = @commentable.comments.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:body)
  end
end
