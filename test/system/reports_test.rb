# frozen_string_literal: true

require 'application_system_test_case'

class ReportsTest < ApplicationSystemTestCase
  setup do
    @report = reports(:report_by_alice)

    visit root_url
    fill_in 'Eメール', with: 'alice@example.com'
    fill_in 'パスワード', with: 'password'
    click_on 'ログイン'

    click_on '日報'
  end

  test 'visiting the index' do
    visit reports_url
    assert_selector 'h1', text: '日報の一覧'
  end

  test 'should create report' do
    visit reports_url
    click_on '日報の新規作成'

    fill_in 'タイトル', with: 'システムテスト作成用の日報タイトル'
    fill_in '内容', with: 'システムテスト作成用の日報内容'
    click_on '登録する'

    assert_text '日報が作成されました。'
    assert_text 'システムテスト作成用の日報タイトル'
    assert_text 'システムテスト作成用の日報内容'

    click_on '日報の一覧に戻る'
  end

  test 'should update Report' do
    visit report_url(@report)
    click_on 'この日報を編集'

    fill_in 'タイトル', with: '日報の更新'
    fill_in '内容', with: '更新テスト'
    click_on '更新する'

    assert_text '日報が更新されました。'
    assert_text '日報の更新'
    assert_text '更新テスト'

    click_on '日報の一覧に戻る'
  end

  test 'should destroy Report' do
    visit reports_url
    assert_text '初めての日報'

    visit report_url(@report)
    click_on 'この日報を削除'

    assert_selector 'h1', text: '日報の一覧'
    assert_text '日報が削除されました。'
    assert_no_text '初めての日報'
  end
end
