# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  test '日報の一覧を見る' do
    click_on '日報'
    assert_selector 'h1', text: '日報の一覧'
    assert_selector 'div#reports', text: 'タイトル:'
    assert_selector 'div#reports', text: '内容:'
    assert_selector 'div#reports', text: '作成者:'
    assert_selector 'div#reports', text: '作成日:'
  end

  test '日報の新規作成' do
    click_on '日報'
    click_on '日報の新規作成'
    fill_in 'タイトル', with: '日報テスト'
    fill_in '内容', with: '日報テストです！'
    click_button '登録する'
    assert_text '日報が作成されました。'
    assert_text '日報テスト'
    assert_text '日報テストです！'
  end

  test '日報を編集する' do
    click_on '日報'
    click_link('この日報を表示', match: :first)
    click_on 'この日報を編集'
    fill_in 'タイトル', with: '日報テスト編集'
    fill_in '内容', with: '日報テストです！編集'
    click_button '更新する'
    assert_text '日報が更新されました。'
    assert_text '日報テスト編集'
    assert_text '日報テストです！編集'
  end

  test '日報を削除する' do
    click_on '日報'
    click_link('この日報を表示', match: :first)
    click_button 'この日報を削除'
    assert_text '日報が削除されました。'
    assert_no_text '日報テスト'
    assert_no_text '日報テストです！'
  end
end
