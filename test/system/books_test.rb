frozen_string_literal: true

require 'application_system_test_case'

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:cherry_book)

    visit root_path
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  test '#本の一覧に戻る' do
    visit books_url
    assert_selector 'h1', text: '本の一覧'
  end

  test '#本の新規作成' do
    visit new_book_path(@book)
    click_on '新規作成'

    fill_in 'タイトル', with: 'Ruby超入門'
    fill_in 'メモ', with: 'すごくわかりやすい！！'
    fill_in '著者', with: 'igaigaさん'
    click_on '登録する'

    assert_text '本が作成されました。'
    click_on '本の一覧に戻る'
  end

  test '#本の編集' do
    visit edit_book_path(@book)
    click_link 'この本を編集'

    fill_in 'タイトル', with: @book.title
    fill_in 'メモ', with: @book.memo
    fill_in '著者', with: @book.author
    click_on '更新する'

    assert_text '本が更新されました。'
    click_on '本の一覧に戻る'
  end

  test '#本を削除' do
    visit book_url(@book)
    click_button 'この本を削除'

    assert_text '本が削除されました。'
  end
end
