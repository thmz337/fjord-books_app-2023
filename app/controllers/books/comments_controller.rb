# frozen_string_literal: true

class Books::CommentsController < CommentsController
  before_action :set_commentable, only: %i[create destroy]

  # POST #{commenatble}/:commentable_id/comments or #{commentable}/:commentable_id/comments.json
  def create
    super
    if @comment.save
      redirect_to book_url(@commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human)
    else
      render 'books/show', status: :unprocessable_entity
    end
  end

  # DELETE #{commentable}/:commentable_id/comments/1 or #{commentable}/:commentable_id/comments/1.json
  def destroy
    super
    redirect_to book_url(@commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human)
  end

  def set_commentable
    @commentable = Book.find(params[:book_id])
  end
end
