class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, format: { with: /\A\w+\z/ }, length: { maximum: 20 }
end
