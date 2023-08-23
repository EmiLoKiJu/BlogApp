require 'rails_helper'

RSpec.describe 'UserPosts', type: :request do
  describe 'GET /user_posts' do
    subject { User.new(name: 'Monika', posts_counter: 0) }
    before { subject.save }

    it 'works' do
      get user_posts_path(user_id: subject.id)
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      get user_posts_path(user_id: subject.id)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholders in body' do
      get user_posts_path(user_id: subject.id)
      expect(response.body).to include('No posts yet')
    end
  end

  describe 'GET /user_post' do
    subject { User.new(name: 'Monika', posts_counter: 0) }
    before do
      subject.save
      @post1 = Post.create(
        title: 'Random title 2',
        text: 'random text 2',
        author_id: subject.id,
        comments_counter: 0,
        likes_counter: 0
      )
      @post1.save
    end

    it 'works' do
      get user_post_path(user_id: subject.id, id: @post1.id)
      expect(response).to have_http_status(200)
    end

    it 'renders the correct template' do
      get user_post_path(user_id: subject.id, id: @post1.id)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholders in body' do
      get user_post_path(user_id: subject.id, id: @post1.id)
      expect(response.body).to include('Random title 2')
    end
  end
end
