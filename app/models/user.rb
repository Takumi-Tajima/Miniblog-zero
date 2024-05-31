class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :active_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy, inverse_of: 'follower'
  has_many :followings, through: :active_relationships, source: :followed
  validates :name, presence: true, format: { with: /\A\w+\z/ }, length: { maximum: 20 }

  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  def unfollow!(user)
    active_relationships.find(followed_id: user.id).destroy!
  end
end
