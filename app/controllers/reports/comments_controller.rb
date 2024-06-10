# frozen_string_literal: true

class Reports::CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]

  # POST #{commenatble}/:commentable_id/comments or #{commentable}/:commentable_id/comments.json
  def create
    comment = @commentable.comments.create(comment_params)
    comment.user = current_user

    if comment.save
      redirect_to report_url(@commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render 'reports/show', status: :unprocessable_entity
    end
  end

  # DELETE #{commentable}/:commentable_id/comments/1 or #{commentable}/:commentable_id/comments/1.json
  def destroy
    return unless @comment.user_id == current_user.id

    @comment.destroy!

    redirect_to report_url(@commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_commentable
    commentable_id = params[:report_id]
    @commentable = Report.find(commentable_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:title, :body)
  end
end
