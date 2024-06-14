# frozen_string_literal: true

class Reports::CommentsController < CommentsController
  before_action :set_commentable, only: %i[create]
  before_action only: %i[destroy] do
    set_commentable
    get_comment(@commentable)
  end

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
    super
    redirect_to report_url(@commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_commentable
    @commentable = Report.find(params[:report_id])
  end
end
