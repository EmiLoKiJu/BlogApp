# Remplazed frozen_string_literal true for something else

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end

  describe 'methods' do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }

    it 'updates user posts counter after creation' do
      expect { post.update_user_posts_counter }.to change { user.reload.posts_counter }.by(1)
    end

    it 'returns recent comments' do
      post.comments.create(author: user, text: 'Comment 1')
      post.comments.create(author: user, text: 'Comment 2')
      post.comments.create(author: user, text: 'Comment 3')
      post.comments.create(author: user, text: 'Comment 4')
      post.comments.create(author: user, text: 'Comment 5')
      post.comments.create(author: user, text: 'Comment 6')

      recent_comments = post.recent_comments(2)
      expect(recent_comments.size).to eq(2)

      post.recent_comments
      expect(recent_comments.size).to eq(5)
    end
  end
end
