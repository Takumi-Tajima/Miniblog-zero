class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  validates :name, presence: true, format: { with: /\A[\w_.-]+\z/, message: 'の入力形式が違います' }, length: { maximum: 20 }
end
