# frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    visit root_path
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  test '#本の一覧を見る' do
    assert_selector 'h1', text: '本の一覧'
    assert_selector 'div#books', text: 'タイトル:'
    assert_selector 'div#books', text: 'メモ:'
    assert_selector 'div#books', text: '著者:'
    assert_selector 'div#books', text: '画像:'
  end

  test '#本の新規作成' do
    click_on '本'
    click_on '本の新規作成'
    fill_in 'タイトル', with: '本の新規作成テスト'
    fill_in 'メモ', with: '本の新規作成テストです！'
    click_button '登録する'
    assert_text '本が作成されました。'
    assert_text '本の新規作成テスト'
    assert_text '本の新規作成テストです！'
  end

  test '#本の編集' do
    click_on '本'
    click_link('この本を表示', match: :first)
    click_on 'この本を編集'
    fill_in 'タイトル', with: '本の編集'
    fill_in 'メモ', with: '本の編集テストです！'
    click_button '更新する'
    assert_text '本が更新されました。'
    assert_text '本の編集'
    assert_text '本の編集テストです！'
  end

  test '#本を削除' do
    click_on '本'
    click_link('この本を表示', match: :first)
    click_button 'この本を削除'
    assert_text '本が削除されました。'
    assert_no_text '本のテスト'
    assert_no_text '本のテストです！'
  end
end
