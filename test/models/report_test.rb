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
    bobs_report = reports(:bobs_report)
    carols_report = reports(:carols_report)
    daisys_report = Report.new(title: '言及テスト', content: "http://localhost:3000/reports/#{bobs_report.id}", user: users(:daisy))

    assert_difference 'ReportMention.count', 1 do
      daisys_report.save
    end

    assert_equal [carols_report, daisys_report], bobs_report.mentioned_reports
    assert_equal [bobs_report], daisys_report.mentioning_reports
  end
end
