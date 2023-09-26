# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    report = reports(:alices_report)
    target_user = users(:alice)
    assert report.editable?(target_user)

    target_user = users(:bob)
    assert_not report.editable?(target_user)
  end

  test '#created_on' do
    report = reports(:alices_report)
    assert_equal Date.new(2023, 9, 11), report.created_on
  end

  test '日報保存後に言及機能が正しく設定されているか確認' do
    user = users(:alice)
    report1 = reports(:alices_report)
    report2 = reports(:bobs_report)
    report = Report.new(title: '言及テスト', content: 'http://localhost:3000/reports/2', user:))

    assert_difference 'ReportMention.count', 1 do
      report.save
    end

    assert_equal [report2], report.active_mentions.map(&:mentioned_by)
    assert_equal [report2], report.mentioning_reports
  end
end
