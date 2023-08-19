# Remplazed frozen_string_literal true for something else

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'Monika', posts_counter: 0) }

  before { subject.save }

  it 'should validate presence of name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it 'should validate numericality of posts_counter, only_integer and greater than or equal to 0' do
    subject.posts_counter = 'string'
    expect(subject).to_not be_valid
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'should have many posts' do
    assc = described_class.reflect_on_association(:posts)
    expect(assc.macro).to eq :has_many
  end

  it 'should have many comments' do
    assc = described_class.reflect_on_association(:comments)
    expect(assc.macro).to eq :has_many
  end

  it 'should have many likes' do
    assc = described_class.reflect_on_association(:likes)
    expect(assc.macro).to eq :has_many
  end

  # rubocop:disable Metrics/BlockLength
  it 'returns recent posts' do
    Post.create(
      title: 'Post 1',
      text: 'Text 1',
      author_id: subject.id,
      comments_counter: 0,
      likes_counter: 0
    )
    Post.create(
      title: 'Post 2',
      text: 'Text 2',
      author_id: subject.id,
      comments_counter: 0,
      likes_counter: 0
    )
    Post.create(
      title: 'Post 3',
      text: 'Text 3',
      author_id: subject.id,
      comments_counter: 0,
      likes_counter: 0
    )
    Post.create(
      title: 'Post 4',
      text: 'Text 4',
      author_id: subject.id,
      comments_counter: 0,
      likes_counter: 0
    )
    Post.create(
      title: 'Post 5',
      text: 'Text 5',
      author_id: subject.id,
      comments_counter: 0,
      likes_counter: 0
    )

    recent_posts = subject.recent_posts(2)
    expect(recent_posts.size).to eq(2)

    recent_posts = subject.recent_posts
    expect(recent_posts.size).to eq(3)
  end
  # rubocop:enable Metrics/BlockLength
end
