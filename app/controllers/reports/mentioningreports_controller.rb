# frozen_string_literal: true

class Reports::MentioningreportsController < ApplicationController
  def index
    @report = Report.find(params[:report_id])
    @mentioning_reports = @report.mentioning_reports.order(id: :desc)
  end
end
