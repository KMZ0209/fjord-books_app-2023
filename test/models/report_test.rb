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

  test '作成された日を確認' do
    report = reports(:alices_report)
    assert_equal Date.new(2023, 9, 11), report.created_on
  end
end
