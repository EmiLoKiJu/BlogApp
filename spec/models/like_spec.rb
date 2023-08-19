# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User') }
    it { should belong_to(:post).class_name('Post') }
  end

  describe 'callbacks' do
    let(:user) { create(:user) }
    let(:post) { create(:post, author: user) }
    let!(:like) { create(:like, author: user, post:) }

    it 'updates post likes counter after creation' do
      expect { like.update_post_likes_counter }.to change { post.reload.likes_counter }.by(1)
    end

    it 'updates post likes counter after destruction' do
      expect { like.destroy }.to change { post.reload.likes_counter }.by(-1)
    end
  end
end
