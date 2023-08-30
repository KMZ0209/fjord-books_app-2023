# frozen_string_literal: true

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  test '#editable?' do
    report = reports(:alices_report)
    target_user = users(:bob)
    assert_not report.editable?(target_user)

    report = reports(:alices_report)
    target_user = users(:alice)
    assert report.editable?(target_user)
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
