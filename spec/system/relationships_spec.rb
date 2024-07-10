require 'rails_helper'

RSpec.describe 'フォロー機能', type: :system do
  let(:user) { create(:user) }
  let(:other) { create(:user) }

  context 'ログインしている時' do
    before do
      sign_in user
      create(:post, user: other, content: 'スタンドのパワーを全開だ')
    end

    it 'フォローできること' do
      visit root_path
      within '.list-group-item' do
        expect(page).to have_content 'スタンドのパワーを全開だ'
        expect do
          click_on 'フォロー'
          expect(page).to have_button 'フォロー解除'
        end.to change(user.active_relationships, :count).by(1)
        expect(page).not_to have_button 'フォロー', exact: true
      end
    end

    it 'フォロー解除できること' do
      create(:relationship, follower_id: user.id, followed_id: other.id)
      visit root_path
      within '.list-group-item' do
        expect(page).to have_content 'スタンドのパワーを全開だ'
        expect do
          click_on 'フォロー解除'
          expect(page).to have_button 'フォロー', exact: true
        end.to change(user.active_relationships, :count).by(-1)
        expect(page).not_to have_button 'フォロー解除'
      end
    end
  end

  context 'ログインしてない時' do
    it 'フォローボタンが表示されないこと' do
      create(:post, user: other, content: 'スタンドのパワーを全開だ')
      visit root_path
      within '.list-group-item' do
        expect(page).to have_content 'スタンドのパワーを全開だ'
        expect(page).not_to have_button 'フォロー解除'
        expect(page).not_to have_button 'フォロー', exact: true
      end
    end
  end
end
