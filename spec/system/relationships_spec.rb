require 'rails_helper'

RSpec.describe 'フォロー機能', type: :system do
  # ユーザーデータを生成x2
  context '他ユーザーをフォローしてない時' do
    before do
      # ユーザーでログイン処理
      # 投稿を作成
    end
    it 'フォローボタンを押すと、フォローできること' do
      # 投稿一覧に訪れる
      # 相手の該当の投稿を確認する
      expect do
        # ボタンを押す
        # フォロー解除が表示されることを確認する
      end # user.relationshipsモデルが+1されている
      # フォローボタンが消えたことを確認する
    end
  end

  context '他のユーザーをフォローしている時' do
    before do
      # ログイン処理
      # 投稿を作成
      # フォロー処理
    end
    it 'フォロー解除ボタンを押すと、フォロー解除できること' do
      # 投稿一覧にいく
      # 投稿を確認する
      expect do
        # フォロー解除を押す
        # 「フォロー解除」ボタンが「フォロー」になる
      end # user.relationshipsモデルが-1されている
      # フォロー解除ボタンがなくなっている
    end
  end

  context 'ログインしてない時' do
    # 投稿を作成→post_foctoryでuserを適当に決める
    it 'フォローボタンが表示されていないこと' do
      # 投稿一覧に訪れる
      # フォローボタンがないことを確認する
    end
  end
end
