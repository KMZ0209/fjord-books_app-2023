# frozen_string_literal: true

require 'application_system_test_case'

class ReportMentionTest < ApplicationSystemTestCase
  setup do
    visit root_url
    fill_in 'Eメール', with: 'carol@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'
  end

  test '言及した日報に言及された日報のURLが含まれている場合、言及された日報に言及した日報のタイトルがリンクとして表示される' do
    click_on '日報'
    assert_selector 'h1', text: '日報の一覧'
    within '.index-item', text: 'タイトル: 言及された日報' do
      click_link 'この日報を表示'
    end
    assert_link '言及テスト'
    assert_text 'carol'
  end

  test '言及した日報を更新して言及された日報内の言及も更新する' do
    click_on '日報'
    assert_selector 'h1', text: '日報の一覧'
    within '.index-item', text: 'タイトル: 言及テスト' do
      click_link 'この日報を表示'
    end
    click_on 'この日報を編集'
    fill_in 'タイトル', with: '言及テスト更新'
    fill_in '内容', with: 'carolの日報本文更新 http://localhost:3000/reports/2'
    click_button '更新する'

    click_on '日報の一覧に戻る'
    assert_selector 'h1', text: '日報の一覧'
    within '.index-item', text: 'タイトル: 言及された日報' do
      click_link 'この日報を表示'
    end
    assert_link '言及テスト更新'
    assert_text 'carol'
  end

  test '言及した日報内で言及された日報への言及を削除する' do
    click_on '日報'
    assert_selector 'h1', text: '日報の一覧'
    within '.index-item', text: 'タイトル: 言及テスト' do
      click_link 'この日報を表示'
    end
    click_on 'この日報を編集'
    fill_in 'タイトル', with: '言及テスト削除'
    fill_in '内容', with: 'carolの日報本文 言及削除'
    click_button '更新する'

    click_on '日報の一覧に戻る'
    assert_selector 'h1', text: '日報の一覧'
    within '.index-item', text: 'タイトル: 言及された日報' do
      click_link 'この日報を表示'
    end
    assert_text '（この日報に言及している日報はまだありません）'
  end
end
