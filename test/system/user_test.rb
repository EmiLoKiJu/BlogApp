require 'application_system_test_case'

class UsersTest < ApplicationSystemTestCase
  #########################
  # Tests for user index
  #########################

  test 'displays the username of all users' do
    visit users_path
    sleep(1)

    assert_text 'username1'
    assert_text 'username2'
  end

  test 'displays the profile picture for each user' do
    visit users_path

    assert_selector('img[alt="Profile photo"]', count: 2)
  end

  test 'displays the number of posts each user has written' do
    visit users_path

    assert_text "posts counter: #{users(:one).posts_counter}"
  end

  test 'redirects to the user show page' do
    visit users_path
    click_link users(:one).name

    assert_current_path(user_path(users(:one)))
  end

  ###############################
  # Tests for user show
  ###############################

  test 'displays the user\'s profile picture' do
    visit user_path(users(:one))

    assert_selector('img[alt="Profile photo"]', count: 1)
  end

  test 'displays the user\'s username' do
    visit user_path(users(:one))

    assert_text 'username1'
  end

  test 'displays the number of posts the user has written' do
    visit user_path(users(:one))

    assert_text "posts counter: #{users(:one).posts_counter}"
  end

  test 'displays the user\'s bio' do
    visit user_path(users(:one))

    assert_text 'bio'
    assert_text users(:one).bio
  end

  test 'displays the user\'s first 3 posts' do
    visit user_path(users(:one))

    three_posts = users(:one).recent_posts
    three_posts.each do |post|
      assert_text post.title
      assert_text post.text
    end
  end

  test 'displays a button that lets me view all of a user\'s posts' do
    visit user_path(users(:one))

    assert_selector('button', text: 'See all posts')
  end

  test 'when I click a user\'s post, it redirects me to that post\'s show page' do
    visit user_path(users(:one))

    three_posts = users(:one).recent_posts
    post1 = three_posts.first
    click_link post1.title

    assert_current_path(user_post_path(users(:one), posts(:one)))
  end

  test 'when I click to see all posts, it redirects me to the user\'s post\'s index page' do
    visit user_path(users(:one))

    click_link 'See all posts'

    assert_current_path(user_posts_path(users(:one)))
  end
end
