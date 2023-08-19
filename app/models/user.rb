# Remplazed frozen_string_literal true for something else

class User < ApplicationRecord
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  has_many :posts, foreign_key: :author_id

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end
end
