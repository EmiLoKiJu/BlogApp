class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post, class_name: 'Post'

  after_create :run_post_comments_counter
  after_destroy :run_post_comments_counter

  def run_post_comments_counter
    post.update(comments_counter: post.comments.count)
  end
end
