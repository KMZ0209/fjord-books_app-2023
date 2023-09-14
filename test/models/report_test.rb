# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test 'editable?' do
    report = reports(:alices_report)
    target_user = users(:alice)
    assert report.editable?(target_user)

    target_user = users(:bob)
    assert_not report.editable?(target_user)
  end

  test 'created_on' do
    report = Report.create(content: '新しいレポート内容', created_at: Time.zone.local(2023, 9, 11, 10, 0, 0))
    assert_equal Date.new(2023, 9, 11), report.created_on
  end

  test 'create_with_mentions' do
    mention = reports(:mention_to)
    mentioned = reports(:mentioned_by)
    assert mention.valid?
  end

  test 'update_with_mentions' do
    report = reports(:mention_to)
    params = { content: '言及内容更新' }
    report.update(params)
    updated_report = Report.find(report.id)
    assert_equal '言及内容更新', updated_report.content
  end
end
