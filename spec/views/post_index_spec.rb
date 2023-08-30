require 'rails_helper'

RSpec.describe 'Posts index', type: :system do
  fixtures :users, :posts, :comments, :likes

  it 'displays the user profile picture' do
    visit user_posts_path(users(:one))
    sleep(1)

    expect(page).to have_selector('img[alt="Profile photo"]', count: 1)
  end

  it 'displays the user username' do
    visit user_posts_path(users(:one))

    expect(page).to have_text('username1')
  end

  it 'displays the number of posts the user has written' do
    visit user_posts_path(users(:one))

    expect(page).to have_text("posts counter: #{users(:one).posts_counter}")
  end

  it 'displays a post title and body' do
    visit user_posts_path(users(:one))
    users(:one).posts.first(1).each do |post|
      expect(page).to have_text(post.title)
      expect(page).to have_text(post.text.slice(0, 165))
    end
  end

  it 'displays the first comments on a post' do
    visit user_posts_path(users(:one))

    users(:one).posts.first(2).each do |post|
      first_comment = post.comments.first
      expect(page).to have_text(first_comment.text.slice(0, 165)) if first_comment
    end
  end

  it 'displays how many comments a post has' do
    visit user_posts_path(users(:one))

    users(:one).posts.first(2).each do |post|
      expect(page).to have_text("Comments: #{post.comments_counter}")
    end
  end

  it 'displays how many likes a post has' do
    visit user_posts_path(users(:one))

    users(:one).posts.first(2).each do |post|
      expect(page).to have_text("Likes: #{post.likes_counter}")
    end
  end

  it 'displays a section for pagination if there are more posts than fit on the view' do
    visit user_posts_path(users(:one))

    expect(page).to have_selector('button', text: 'Next Page')
  end

  it 'when click on a post, it redirects me to that post show page' do
    visit user_posts_path(users(:one))

    post1 = users(:one).posts.first
    click_link post1.title
    expect(page).to have_current_path(user_post_path(users(:one), post1))
  end
end
