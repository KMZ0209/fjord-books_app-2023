# frozen_string_literal: true

class Report < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :active_mentions, class_name: 'Mention',
                             foreign_key: 'mentioning_report_id',
                             dependent: :destroy,
                             inverse_of: :mentioning_report

  has_many :passive_mentions, class_name: 'Mention',
                              foreign_key: 'mentioned_report_id',
                              dependent: :destroy,
                              inverse_of: :mentioned_report

  has_many :mentioning_reports, through: :active_mentions, source: :mentioned_report
  has_many :mentioned_reports, through: :passive_mentions, source: :mentioning_report

  validates :title, presence: true
  validates :content, presence: true

  def edit_user(target_user)
    user == target_user
  end

  def created_date
    created_at.to_date
  end

  def create_with_mentions
    Report.transaction do
      @report = current_user.reports.new(report_params)
      if @report.save && update_mentions
        redirect_to @report
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update_with_mentions(params)
    Report.transaction do
      if update(params) && update_mentions
        redirect_to @report
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def update_mentions
    new_mentioned_report_ids = content.scan(%r{http://localhost:3000/reports/(\d+)}).flatten.uniq
    new_mentioned_reports = Report.where(id: new_mentioned_report_ids).where.not(id: current_user)
    Mention.transaction do
      active_mentions.destroy_all
      new_mentioned_reports.each do |new_mentioned_report|
        mentioning_reports << new_mentioned_report
      end
    end
  end
end
