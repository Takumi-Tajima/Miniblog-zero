class Post < ApplicationRecord
  belongs_to :user
  scope :default_order, -> { order(updated_at: :desc) }
end
