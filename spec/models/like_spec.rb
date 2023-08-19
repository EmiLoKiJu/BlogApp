# Remplazed frozen_string_literal true for something else

require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { Like.new }

  before do
    @user1 = User.create(
      name: 'Monika',
      photo: 'https://google.cl',
      bio: 'Singer',
      posts_counter: 0
    )
    @user1.save
    @post1 = Post.create(
      title: 'random title',
      text: 'random text',
      author_id: @user1.id,
      comments_counter: 0,
      likes_counter: 0
    )
    @post1.save
    subject.save
  end

  it 'should belong to an author' do
    assc = described_class.reflect_on_association(:author)
    expect(assc.macro).to eq :belongs_to
    expect(assc.options[:class_name]).to eq 'User'
  end

  it 'should belong to a post' do
    assc = described_class.reflect_on_association(:post)
    expect(assc.macro).to eq :belongs_to
    expect(assc.options[:class_name]).to eq 'Post'
  end

  it 'updates post likes counter after creation' do
    @like1 = Like.create(author_id: @user1.id, post_id: @post1.id)
    post1 = Post.find(@post1.id)
    expect(post1.likes_counter).to eq(1)
  end

  it 'updates post likes counter after destruction' do
    @like1 = Like.create(author_id: @user1.id, post_id: @post1.id)
    @like1.destroy
    post1 = Post.find(@post1.id)
    expect(post1.likes_counter).to eq(0)
  end
end
