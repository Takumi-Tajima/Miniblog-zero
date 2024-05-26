require 'rails_helper'

RSpec.describe 'ポスト機能', type: :system do
  context 'ログインしてない時' do
    let(:user) { create(:user, name: 'hoge') }
    let!(:post) { create(:post, user:, content: 'hogehoge') }

    it 'ポストの投稿一覧を閲覧できること' do
      visit root_path
      # 投稿者名
      expect(page).to have_content 'hoge'
      # 投稿本文
      expect(page).to have_content 'hogehoge'
    end

    it 'ポストの詳細画面を閲覧できること' do
      visit post_path(post)
      # 投稿者名
      expect(page).to have_content 'hoge'
      # 投稿本文
      expect(page).to have_content 'hogehoge'
    end
  end

  context 'ログインしてる時' do
    let!(:user) { create(:user, name: 'jojo') }

    before do
      sign_in user
    end

    it 'ポストの新規作成ができること' do
      visit root_path
      click_on '新規投稿'
      fill_in '内容', with: 'fuga'
      expect do
        click_on '作成'
        expect(page).to have_content '投稿を登録しました'
      end.to change(user.posts).by(1)
      expect(page).to have_content 'fuga'
      expect(page).to have_content 'jojo'
    end

    it '自分のポストは編集ができること' do
      post = create(:post, user:, content: 'oraora')
      visit post_path(post)
      expect(page).to have_content 'oraora'
      expect(page).to have_content 'jojo'
      click_on '編集'
      fill_in '内容', with: 'mudamuda'
      click_on '更新'
      expect(page).to have_content '投稿を編集しました'
      expect(page).not_to have_content 'oraora'
      expect(page).to have_content 'mudamuda'
    end

    it '自分のポストは削除できること' do
      post = create(:post, user:, content: 'wryyy')
      visit root_path
      click_on 'wryyy'
      expect(page).to have_current_path post_path(post)
      click_on '削除'
      expect(page).to have_content '投稿を削除しました'
      expect(page).not_to have_content 'wryyy'
    end

    context '他人の投稿の時' do
      let(:other_user) { create(:user, name: 'dio') }

      before do
        create(:post, user: other_user, content: 'bread')
      end

      it 'ポストの編集ができないこと' do
        visit root_path
        click_on 'bread'
        expect(page).not_to have_content '編集'
      end

      it 'ポストの削除ができないこと' do
        visit root_path
        click_on 'bread'
        expect(page).not_to have_content '削除'
      end
    end
  end
end
