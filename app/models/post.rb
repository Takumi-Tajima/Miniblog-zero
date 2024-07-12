class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  scope :default_order, -> { order(updated_at: :desc) }

  def liked_by?(user)
    # こっちだとN+1問題が発生する
    # likes.exists?(user_id:)
    likes.any? { |like| like.user_id == user.id }
  end
end
