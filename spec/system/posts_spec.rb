require 'rails_helper'

RSpec.describe 'ポスト投稿機能', type: :system do
  # ログインしてない時
  context 'ログインしてない時' do
    let!(:user) { create(:user, name: 'hoge') }
    let(:post) { create(:post, content: 'hogehoge') }

    it 'ポストの投稿一覧を閲覧できること' do
      visit root_path
      # 投稿者名
      expect(page).to have_content 'hoge'
      # 投稿本文
      expect(page).to have_content 'hogehoge'
    end

    it 'ポストの詳細画面を閲覧できること' do
      visit post_path(post)
      click_on 'hogehoge'
      # 投稿者名
      expect(page).to have_content 'hoge'
      # 投稿本文
      expect(page).to have_content 'hogehoge'
    end
  end

  # ログインしてる時
  context 'ログインしてる時' do
    let(:user) { create(:user) }

    before do
      sign_in user
    end

    # ポストの新規作成ができること
    visit root_path
    click_on '新規投稿'
    fill_in '内容', with: 'fuga'
    expect do
      click_on '更新'
      expect(page).to have_current_path post_path
    end.to change(user.posts).by(1)
    expect(page).to have_content 'fuga'
    # 自分の投稿の時
    context '自分の投稿の時' do
      # ポストの編集ができること
      # ポストの削除ができること
    end

    # 他人の投稿の時
    context '他人の投稿の時' do
      # ポストの編集ができないこと
      # ポストの削除ができないこと
    end
  end
end
