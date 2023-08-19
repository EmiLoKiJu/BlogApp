# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post).class_name('Post') }
  end

  describe 'callbacks' do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }
    let!(:comment) { create(:comment, author: user, post:) }

    it 'updates post comments counter after creation' do
      expect { comment.update_post_comments_counter }.to change { post.reload.comments_counter }.by(1)
    end

    it 'updates post comments counter after destruction' do
      expect { comment.destroy }.to change { post.reload.comments_counter }.by(-1)
    end
  end
end
