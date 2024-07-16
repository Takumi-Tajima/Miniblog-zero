class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy, inverse_of: 'follower'
  has_many :passive_relationships, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy, inverse_of: 'followed'
  has_many :followings, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  validates :name, presence: true, format: { with: /\A[\w_.-]+\z/, message: 'の入力形式が違います' }, length: { maximum: 20 }

  def following?(user)
    followings.include?(user)
  end
end
