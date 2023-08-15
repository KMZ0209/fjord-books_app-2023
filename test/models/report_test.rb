# frozen_string_literal: true

# require 'test_helper'
require 'application_system_test_case'

class ReportTest < ApplicationSystemTestCase
  setup do
    @report = reports(:test_report)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_button 'ログイン'
  end

  test '#editable?' do
    user = User.new(name: 'John')
    target_user = User.new(name: 'John')
    report = Report.new(user:)
    assert_not report.editable?(target_user)
  end

  test '#created_on' do
    report = Report.create(created_at: Time.zone.local(2023, 8, 7, 12, 0, 0))
    expected_date = Date.new(2023, 8, 7)
    assert_equal expected_date, report.created_on
  end

  test '#save_mentions' do
    report1 = Report.create(id: 1, content: 'http://localhost:3000/reports/1')
    report2 = Report.create(id: 2, content: 'http://localhost:3000/reports/2')
    report3 = Report.create(id: 3, content: 'http://localhost:3000/reports/3')
    report1.mentioning_reports << report2
    report1.send(:save_mentions)
    assert_includes report1.mentioning_reports, report2
    assert_not_includes report1.mentioning_reports, report3
  end
end
