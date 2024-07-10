class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy, inverse_of: 'follower'
  has_many :followings, through: :active_relationships, source: :followed
  validates :name, presence: true, format: { with: /\A[\w_.-]+\z/, message: 'の入力形式が違います' }, length: { maximum: 20 }

  def following?(user)
    followings.include?(user)
  end
end
