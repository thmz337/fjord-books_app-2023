# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_commentable, only: %i[create destroy]
  before_action :set_comment, only: %i[destroy]

  # POST #{commenatble}/:commentable_id/comments or #{commentable}/:commentable_id/comments.json
  def create
    params_for_comment_creation = comment_params.to_h
    params_for_comment_creation[:user_id] = current_user.id
    params_for_comment_creation[:name] = current_user.email if params_for_comment_creation[:name].empty?
    @comment = @commentable.comments.create(params_for_comment_creation)

    commentable_class_name = @commentable.class.name.downcase
    # for show method of commentable
    instance_variable_set("@#{commentable_class_name}".to_sym, @commentable)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to report_url(@commentable), notice: t('controllers.common.notice_create', name: Comment.model_name.human) }
        format.json { render :show, status: :created, location: @commentable }
      else
        format.html { render 'reports/show', status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE #{commentable}/:commentable_id/comments/1 or #{commentable}/:commentable_id/comments/1.json
  def destroy
    return unless @comment.user_id == current_user.id

    @comment.destroy

    respond_to do |format|
      format.html { redirect_to report_url(@commentable), notice: t('controllers.common.notice_destroy', name: Comment.model_name.human) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_commentable
    url_path_elements = request.path.split(%r{/})[1..]

    case url_path_elements
    in ['reports', *]
      @commentable = Report.find(params['report_id'])
    in ['books', *]
      @commentable = Book.find(params['book_id'])
    end
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:name, :body)
  end
end
