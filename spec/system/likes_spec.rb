require 'rails_helper'

RSpec.describe 'いいね機能', type: :system do
  context 'ログインしてない時' do
    let(:user) { create(:user) }
    let(:other) { create(:user) }
    let(:post) { create(:post, user: other, content: 'wryyyyyyy') }

    before do
      create(:like, user: other, post:)
    end

    it 'いいねボタン、いいねの数が表示されている' do
      visit root_path
      within('.list-group-item') do
        expect(page).to have_content 'wryyyyyyy'
        expect(page).to have_css 'button[test_id="like"]'
        expect(page).to have_link 1, href: post_like_users_path(post)
      end
    end

    it 'いいねボタンを押すとログイン画面に遷移する' do
      visit root_path
      find('button[test_id="like"]').click
      expect(page).to have_content 'ログインもしくはアカウント登録してください。'
    end
  end

  context 'ログインしている時' do
    let(:user) { create(:user) }
    let(:sony) { create(:user, name: 'sony') }
    let(:michael) { create(:user, name: 'michael') }
    let!(:post) { create(:post, user:) }

    before do
      sign_in user
    end

    it 'いいねができること' do
      visit root_path
      within('.list-group-item') do
        expect do
          find('button[test_id="like"]').click
          expect(page).to have_css('button[test_id="not-like"]')
        end.to change(user.likes, :count).by(1)
        expect(page).to have_link 1, href: post_like_users_path(post)
      end
    end

    it 'いいねを消せること' do
      user.likes.create(post_id: post.id)
      visit root_path
      within('.list-group-item') do
        expect(page).to have_link 1, href: post_like_users_path(post)
        expect do
          find('button[test_id="not-like"]').click
          expect(page).to have_css('button[test_id="like"]')
        end.to change(user.likes, :count).by(-1)
        expect(page).not_to have_link 1, href: post_like_users_path(post)
      end
    end

    it 'いいねしたユーザーの一覧を確認できる' do
      sony.likes.create(post_id: post.id)
      michael.likes.create(post_id: post.id)
      visit root_path
      within('.list-group-item') do
        click_link '2', href: post_like_users_path(post)
      end
      expect(page).to have_content 'いいねしたユーザー一覧'
      expect(page).to have_content 'michael'
      expect(page).to have_content 'sony'
    end
  end
end
