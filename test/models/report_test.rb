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
    user = users(:carol)
    mentioned_report = reports(:bobs_report)
    mentioning_report = Report.new(title: '言及テスト', content: 'http://localhost:3000/reports/2', user:)

    assert_difference 'ReportMention.count', 1 do
      mentioning_report.save
    end

    assert_equal [reports(:carols_report)], mentioned_report.mentioning_reports
    assert_equal [], mentioning_report.mentioned_reports
  end
end
