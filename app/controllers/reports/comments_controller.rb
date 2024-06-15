# frozen_string_literal: true

class Reports::CommentsController < CommentsController
  before_action :set_commentable
  before_action :set_comment, only: %i[destroy]

  def create
    super('reports/show')
  end
  
  def set_commentable
    @commentable = Report.find(params[:report_id])
  end
end
