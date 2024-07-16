require 'rails_helper'

RSpec.describe 'フォロー機能', type: :system do
  let(:user) { create(:user) }
  let(:other) { create(:user, name: 'dio') }

  context 'ログインしている時' do
    let(:post) { create(:post, user: other, content: 'スタンドのパワーを全開だ') }

    before do
      sign_in user
    end

    it 'フォローできること' do
      visit post_path(post)
      expect(page).to have_content 'dio'
      expect(page).to have_content 'スタンドのパワーを全開だ'
      expect do
        click_on 'フォロー'
        expect(page).to have_button 'フォロー解除'
      end.to change(user.active_relationships, :count).by(1)
      expect(page).not_to have_button 'フォロー', exact: true
    end

    it 'フォロー解除できること' do
      create(:relationship, follower_id: user.id, followed_id: other.id)
      visit post_path(post)
      expect do
        click_on 'フォロー解除'
        expect(page).to have_button 'フォロー', exact: true
      end.to change(user.active_relationships, :count).by(-1)
      expect(page).not_to have_button 'フォロー解除'
    end
  end

  context 'ログインしてない時' do
    let(:post) { create(:post, user: other, content: 'hogehoge') }

    it 'フォローボタンが表示されないこと' do
      visit post_path(post)
      expect(page).to have_content 'hogehoge'
      expect(page).not_to have_button 'フォロー解除'
      expect(page).not_to have_button 'フォロー', exact: true
    end
  end
end
