# frozen_string_literal: true

class ReportsController < ApplicationController
  before_action :set_report, only: %i[edit update destroy]

  def index
    @reports = Report.includes(:user).order(id: :desc).page(params[:page])
  end

  def show
    @report = Report.find(params[:id])
    @reports_mentioning = @report.mentioned_reports
  end

  # GET /reports/new
  def new
    @report = current_user.reports.new
  end

  def edit; end

  def create
    @report = current_user.reports.new(report_params)

    if @report.save
      mention_registration(@report)
      redirect_to @report, notice: t('controllers.common.notice_create', name: Report.model_name.human)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @report.update(report_params)
      mention_registration(@report)
      redirect_to @report, notice: t('controllers.common.notice_update', name: Report.model_name.human)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @report.destroy

    redirect_to reports_url, notice: t('controllers.common.notice_destroy', name: Report.model_name.human)
  end

  private

  def set_report
    @report = current_user.reports.find(params[:id])
  end

  def report_params
    params.require(:report).permit(:title, :content)
  end

  def mention_registration(report)
    report_mentioning_ids = report.content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.uniq.map(&:to_i)

    exist_report_mentioning_ids = []

    report_mentioning_ids.each do |report_mentioning_id|
      exist_report_mentioning_ids << report_mentioning_id if Report.where(id: report_mentioning_id).exists? && report.id != report_mentioning_id
    end

    report.mentioning_report_ids = exist_report_mentioning_ids
  end
end
