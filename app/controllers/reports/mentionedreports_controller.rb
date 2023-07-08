# frozen_string_literal: true

class Reports::MentionedreportsController < ApplicationController
  def index
    @report = Report.find(params[:report_id])
    @mentioned_reports = @report.mentioned_reports.order(id: :desc)
  end
end
