# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:test_report)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  # test '#日報の一覧に戻る' do
  #   visit reports_url
  #   assert_selector 'h1', text: '日報の一覧'
  # end

  test '#日報の新規作成' do
    click_on '日報'
    visit reports_path
    click_on '日報の新規作成'
    fill_in 'タイトル', with: '日報テスト'
    fill_in '内容', with: '日報テストです！！'
    # # fill_in '作成者', with: @report.user
    click_button '登録する'

    assert_text '日報が作成されました。'
  end

  test '#この日報を編集' do
    click_on '日報'
    visit reports_path
    click_on 'この日報を表示'
    click_on 'この日報を編集'
    fill_in 'タイトル', with: @report.title
    fill_in '内容', with: @report.content
    # fill_in '作成者', with: user.user_id
    click_button '更新する'
    assert_text '日報が更新されました。'
  end

  test '#この日報を削除' do
    click_on '日報'
    visit reports_path
    click_on 'この日報を表示'
    click_button 'この日報を削除'
    assert_text '日報が削除されました。'
  end
end
