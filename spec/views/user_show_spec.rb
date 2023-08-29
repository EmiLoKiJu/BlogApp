require 'rails_helper'

RSpec.describe 'User show', type: :system do
  fixtures :users, :posts, :comments, :likes

  it 'displays the user\'s profile picture' do
    visit user_path(users(:one))

    expect(page).to have_selector('img[alt="Profile photo"]', count: 1)
  end

  it 'displays the user\'s username' do
    visit user_path(users(:one))

    expect(page).to have_text('username1')
  end

  it 'displays the number of posts the user has written' do
    visit user_path(users(:one))

    expect(page).to have_text("posts counter: #{users(:one).posts_counter}")
  end

  it 'displays the user\'s bio' do
    visit user_path(users(:one))

    expect(page).to have_text('bio')
    expect(page).to have_text(users(:one).bio)
  end

  it 'displays the user\'s first 3 posts' do
    visit user_path(users(:one))

    three_posts = users(:one).recent_posts
    three_posts.each do |post|
      expect(page).to have_text(post.title)
      expect(page).to have_text(post.text)
    end
  end

  it 'displays a button that lets me view all of a user\'s posts' do
    visit user_path(users(:one))

    expect(page).to have_selector('button', text: 'See all posts')
  end

  it 'when I click a user\'s post, it redirects me to that post\'s show page' do
    visit user_path(users(:one))

    three_posts = users(:one).recent_posts
    post1 = three_posts.first
    click_link post1.title

    expect(page).to have_current_path(user_post_path(users(:one), posts(:one)))
  end

  it 'when I click to see all posts, it redirects me to the user\'s post\'s index page' do
    visit user_path(users(:one))

    click_link 'See all posts'

    expect(page).to have_current_path(user_posts_path(users(:one)))
  end
end