# frozen_string_literal: true

class Reports::CommentsController < CommentsController
  def loaded_view = 'reports/show'

  def set_commentable
    @commentable = Report.find(params[:report_id])
  end
end
