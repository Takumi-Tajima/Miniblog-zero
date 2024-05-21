class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, format: { with: /\A[a-zA-Z0-9]+\z/ }, length: { maximum: 20 }
end
