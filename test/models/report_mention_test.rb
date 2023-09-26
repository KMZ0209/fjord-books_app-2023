# frozen_string_literal: true

require 'test_helper'

class ReportMentionTest < ActiveSupport::TestCase
  test '日報への言及が有効か確認' do
    report_mention = report_mentions(:mention_carols_report_to_bobs_report)
    assert report_mention.valid?
  end

  test 'mentioned_byとmention_toの組み合わせが一意であることを要求' do
    duplicate_mention = ReportMention.new(
      mentioned_by_id: 1,
      mention_to_id: 2
    )
    assert_not duplicate_mention.valid?
  end

  test '' do
  end
end
